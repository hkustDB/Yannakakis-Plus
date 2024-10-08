# Yannakakis <sup style="float: right;">+</sup>

## Experiments

### Requirements
- Java JDK or JRE(Java Runtime Environment). This program use one `jar` file to parse the query and generate the related information.
- Python version >= 3.9
- Python package requirements: docopt, requests

### Steps
1. Modify path for `python` in `auto_rewrite.sh`.
2. Execute the following command to get the rewrite querys. The rewrite time is shown in `rewrite_time.txt`
3. OPTIONS
- Mode: Set generate code mode D(DuckDB)/M(MySql) [default: D]
- Yannakakis/# Yannakakis <sup style="float: right;">+</sup>
: Set Y for Yannakakis; N for # Yannakakis <sup style="float: right;">+</sup>
 [default: N]
```
$ bash start_parser.sh
$ Parser started.
$ ./auto_rewrite.sh ${DDL_NAME} ${QUERY_DIR} [OPTIONS]
e.g ./auto_rewrite.sh lsqb lsqb M N
```

#### NOTE
- Use `jps` command to get the parser pid which name is `jar`, and then kill it. 


