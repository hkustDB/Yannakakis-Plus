# Yannakakis-Plus

## Experiments

### Requirements
- Java JDK or JRE(Java Runtime Environment). This program use one `jar` file to parse the query and generate the related information.
- Python version >= 3.9
- Python package requirements: docopt, requests

### Steps
0. Preprocessing[option]. For generating new statistics (`cost.csv`), we offer the DuckDB version scripts `preprocess.sh` and `gen_cost.sh`. Modify the configurations in them, and execute the following command. 
```
$ ./preprocess.sh
```
1. Modify path for `python` in `auto_rewrite.sh`.
2. Execute the following command to get the rewrite querys. The rewrite time is shown in `rewrite_time.txt`
3. OPTIONS
- Mode: Set generate code mode D(DuckDB)/M(MySql) [default: D]
- Yannakakis/Yannakakis-Plus
: Set Y for Yannakakis; N for Yannakakis-Plus
 [default: N]
```
$ bash start_parser.sh
$ Parser started.
$ ./auto_rewrite.sh ${DDL_NAME} ${QUERY_DIR} [OPTIONS]
e.g ./auto_rewrite.sh lsqb lsqb M N
```
4. Modify configurations in `load_XXX.sql` (load table schemas) and `auto_run_XXX.sh` (auto-run script for different DBMSs). 
5. Execute the following command to execute the queries in different DBMSs.
```
$ ./auto_run_XXX.sh [OPTIONS]
```

### Structure
- `./query/[graph|lsqb|tpch|job]`: plans for different DBMSs
- `./query/*.sh`: auto-run scripts
- `./query/*.sql`: load data scripts
- `./query/[src|Schema]`: files for auto-run SparkSQL
- `./*.py`: code for rewriter and optimizer
- `./sparksql-plus-web-jar-with-dependencies.jar`: parser jar file

#### NOTE
- For queries like `SELECT DISTINCT ...`, please remove `DISTINCT` keyword before parsing. 
- Use `jps` command to get the parser pid which name is `jar`, and then kill it. 


