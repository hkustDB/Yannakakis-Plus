# Query Optimization By Rewriting

## Experiments

### Requirements
- Java JDK or JRE(Java Runtime Environment). This program use one `jar` file to parse the query and generate the related information.
- Python version >= 3.9
- Python package requirements: docopt, requests

### Steps
1. Modify path for `python` in `auto_rewrite.sh`.
2. Execute the following command to get the rewrite querys. The rewrite time is shown in `rewrite_time.txt`.
```
$ bash start_parser.sh
$ Parser started.
$ ./auto_rewrite.sh ${DDL_NAME} ${QUERY_DIR} [OPTIONS]
e.g ./auto_rewrite.sh lsqb lsqb
```
3. Modify the path to graph/lsqb/tpch data in `query/load_*.sql`, and change the table schema if needed. 
4. Execute `quey/init_schema*.sh` to set up the database. 
- Format
```
./init_schema_adb.sh ${MACHINE} ${DATABASE}
    or
./init_schema.sh ${DATABASE}
```
- Example
```
$ ./init_schema_adb.sh 1 tpch
    or
$ ./init_schema.sh tpch
```
5. Execute `query/auto_run*.sh` to auto-test the rewriting querys and the running time is shown in `log_query.txt` or `log_rewrite*.txt`. 
- Format
```
./auto_run_adb.sh ${MACHINE} ${QUERY_DIR}
    or
./auto_run.sh ${DATABASE} ${QUERY_DIR}
```
- Example
```
$ ./auto_run_adb.sh 1 tpch
    or
$ ./auto_run.sh tpch tpch
```

 #### NOTE
 1. Use `jps` command to get the parser pid which name is `jar`, and then kill it. 
 2. For adb, use `1` or `4` to select different sets of machines. 
