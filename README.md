# Relational Algorithms for Top-k Query Evaluation

This project provides the experiment rewriter code of the paper: Relational Algorithms for Top-k Query Evaluation.

## Queries

The experiment queries, including the original queries and queries after rewriting, are provided in the directory `topk1/*`, `topk2/*`, `topk3/*`, `topk4/*`, `topk5/*`. 

## Graph Data

All graph data can be downloaded from SNAP (https://snap.stanford.edu).


## Experiments
### Requirements
- Java JDK or JRE(Java Runtime Environment). This program use one `jar` file to parse the query and generate the related information.
- Python version >= 3.9

### Previous settings
 1. Change `BASE_PATH` value in `main.py`, which correspond to the target query.
 2. Change `DDL_NAME` value in `main.py`, which correspond to the query's ddl file.
 3. Change `TopK` value in `main.py` to `0` or `1` for different algorithms for topk,  where `0` means selecting level-k algorithm and `1` means selecting product-k algorithm. 
 4. Change `base` value in `main.py` to the base of logarithms, the default value is `32`. This one is needed for level-k algorithm. 

### Command
```
$ cd SQLRewriter/
$ java -jar sparksql-plus-web-jar-with-dependencies.jar
$ python3 main.py
```
- The current generated result is shown as `rewrite0.txt`
- The previous generated results are stored in `levelkM/*`, `productkM/*` for Mysql; `levelkD/*`, `productkD/*` for DuckDB. 

