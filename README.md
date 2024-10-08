<h1 style="display: flex; justify-content: space-between; align-items: center;">
  <span>Yannakakis</span>
  <sup>+</sup>
</h1>

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
e.g ./auto_rewrite.sh lsqb lsqb -g M -y N
```

#### NOTE
 1. Use `jps` command to get the parser pid which name is `jar`, and then kill it. 
 2. For adb, use `1` or `4` to select different sets of machines. 
 3. options
```
-g, --genType type    Set generate code mode D(DuckDB)/M(MySql) [default: D]
-y, --yanna yanna     Set Y for yannakakis generation; N for our rewrite [default: N]
```
