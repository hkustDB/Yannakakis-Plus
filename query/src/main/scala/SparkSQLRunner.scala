import com.alibaba.druid.sql.ast.SQLStatement
import com.alibaba.druid.sql.ast.statement.SQLColumnDefinition
import com.alibaba.druid.sql.dialect.mysql.ast.statement.MySqlCreateTableStatement
import com.alibaba.druid.sql.dialect.mysql.parser.MySqlStatementParser
import org.apache.spark.sql.types._
import org.apache.spark.sql.{DataFrame, SparkSession}
import org.apache.spark.{SparkConf, SparkContext}

import java.nio.file.{FileSystems, Files}
import scala.collection.JavaConverters.asScalaIteratorConverter
import scala.collection.mutable
import scala.io.Source
import scala.sys.exit

object SparkSQLRunner {

    val structTypeMap: mutable.Map[String, StructType] = mutable.Map()

    def loadSchema(schemaPath: String): Unit = {
        val content: String = readSchema(schemaPath)
        // initial schema
        val createTableSQL: mutable.StringBuilder = new mutable.StringBuilder
        content.lines.foreach(line => {
            if (line.contains(";")) {
                val idx: Int = line.indexOf(';')
                createTableSQL.append(line.substring(0, idx))
                // using druid to parse all table
                val parser: MySqlStatementParser = new MySqlStatementParser(createTableSQL.toString)
                val statement: SQLStatement = parser.parseStatement
                var structFieldList: List[StructField] = List()
                if (statement.isInstanceOf[MySqlCreateTableStatement]) {
                    val createStatement = statement.asInstanceOf[MySqlCreateTableStatement]
                    createStatement.getTableElementList.forEach(field => {
                        // extract all fields
                        if (field.isInstanceOf[SQLColumnDefinition]) {
                            val column: SQLColumnDefinition = field.asInstanceOf[SQLColumnDefinition]
                            val fieldName: String = column.getName.getSimpleName
                            val dataType: String = column.getDataType.getName
                            val nullable: Boolean = !column.containsNotNullConstaint
                            structFieldList :+= StructField(fieldName, transform(dataType), nullable)
                        }
                    })
                    val structType: StructType = StructType(structFieldList)
                    structTypeMap += (createStatement.getName.getSimpleName -> structType)
                    println(createStatement.getName.getSimpleName)
                }
                createTableSQL.clear()
                createTableSQL.append(line.substring(idx + 1))
            } else {
                createTableSQL.append(line)
            }
        })
    }

    def transform(dataType: String): DataType = dataType.toLowerCase match {
        // transform data type from SQL to Spark DataFrame
        case "integer" => IntegerType
        case "decimal" => DoubleType
        case "double" => DoubleType
        case "char" => StringType
        case "varchar" => StringType
        case "date" => DateType
        case "time" => DateType
        case "bigint" => LongType
    }

    def readSchema(sqlPath: String): String = {
        val lines: Iterator[String] = Source.fromFile(sqlPath, "UTF-8").getLines()
        val stringBuilder: mutable.StringBuilder = new mutable.StringBuilder
        lines.foreach(line => stringBuilder.append(line).append("\n"))
        stringBuilder.toString
    }

    def readQuerySQL(sqlPath: String): List[String] = {
        // read sql from given path.
        val lines: Iterator[String] = Source.fromFile(sqlPath, "UTF-8").getLines()
        val stringBuilder: mutable.StringBuilder = new mutable.StringBuilder
        lines.foreach(line => stringBuilder.append(line).append("\n"))
        val total = stringBuilder.toString

        total.split(";").map(s => s.trim).filter(s => s.nonEmpty).toList
    }

    def loadData(sparkSession: SparkSession, dataDir: String): Unit = {
        println("Tables to load:")
        structTypeMap.keys.foreach(println)

        // load data into data frame
        structTypeMap.keys.foreach(tableName => {
            val structType: StructType = structTypeMap(tableName)
            val dataFrame: DataFrame = sparkSession.createDataFrame(sparkSession.sqlContext.read.option("sep", "|").schema(structType).csv(dataDir + "/" + tableName + ".csv").rdd, structType)
            // Cache the dataFrame into memory
            dataFrame.cache()
            dataFrame.createOrReplaceTempView(tableName)
            dataFrame.count()
            println("Loaded table " + tableName)
        })
    }

    def main(args: Array[String]): Unit = {
        if (args.length < 3) exit(-1)
        val dataDir: String = args.apply(0)
        val sqlBasePath: String = args.apply(1)
        val schemaPath: String = args.apply(2)

        loadSchema(schemaPath)
        val conf = new SparkConf()
        conf.setAppName("SparkSQLRunner")

        val sc = new SparkContext(conf)
        val sparkSession = SparkSession.builder.config(sc.getConf).getOrCreate

        val queryName2QueryPath = mutable.HashMap.empty[String, String]
        val queryName2CleanPath = mutable.HashMap.empty[String, String]
        val dir = FileSystems.getDefault.getPath(sqlBasePath)
        Files.list(dir).iterator().asScala.foreach(p => {
            val fileName = p.getFileName.toString
            if (fileName.endsWith(".sql") && !fileName.endsWith("_clean.sql")) {
                val queryName = fileName.substring(0, fileName.length - 4)
                queryName2QueryPath(queryName) = p.toString
            } else if (fileName.endsWith("_clean.sql")) {
                val queryName = fileName.substring(0, fileName.length - 10)
                queryName2CleanPath(queryName) = p.toString
            }
        })

        println("Query list:")
        queryName2QueryPath.foreach(kv => println(s"Query=${kv._1}, Sql=${kv._2}"))

        val queryName2QuerySQLs: Map[String, List[String]] = queryName2QueryPath.map(t => (t._1, readQuerySQL(t._2))).toMap
        loadData(sparkSession, dataDir)
        println("Loaded Data.")
        println()
        val queryName2CleanSQLs: Map[String, List[String]] = queryName2CleanPath.map(t => (t._1, readQuerySQL(t._2))).toMap


        for (kv <- queryName2QuerySQLs) {
            val queryName = kv._1
            val querySQLs = kv._2
            println(s"Run Query $queryName")

            try {
                if (queryName2CleanPath.contains(queryName)) {
                    val cleanSQLs = queryName2CleanSQLs(queryName)
                    for (sql <- cleanSQLs) {
                        sparkSession.sqlContext.sql(sql)
                    }
                }

                val startTime = System.currentTimeMillis()
                for (sql <- querySQLs.init) {
                    sparkSession.sqlContext.sql(sql)
                }
                val dataFrame: DataFrame = sparkSession.sqlContext.sql(querySQLs.last)
                println(dataFrame.count())
                val endTime = System.currentTimeMillis()
                println(s"Query ${queryName} Time: " + (endTime - startTime) + "ms")
                println()

                if (queryName2CleanPath.contains(queryName)) {
                    val cleanSQLs = queryName2CleanSQLs(queryName)
                    for (sql <- cleanSQLs) {
                        sparkSession.sqlContext.sql(sql)
                    }
                }
                sparkSession.sqlContext.sql("CLEAR CACHE;")
            } catch {
                case e: Exception =>
                    println("Exception thrown in Query " + queryName)
                    e.printStackTrace()
            }
        }
    }
}