create table epinions
(
    src integer,
    dst integer
) USING CSV LOCATION '/home/bchenba/SparkSQLRunner/Data/epinions.csv';
create table Graph
(
    src integer,
    dst integer
) USING CSV LOCATION '/home/bchenba/SparkSQLRunner/Data/Graph.csv';
create table bitcoin
(
    src integer,
    dst integer,
    weight integer
) USING CSV LOCATION '/home/bchenba/SparkSQLRunner/Data/bitcoin.csv';
create table dblp
(
    src integer,
    dst integer
) USING CSV LOCATION '/home/bchenba/SparkSQLRunner/Data/dblp.csv';
create table google
(
    src integer,
    dst integer
) USING CSV LOCATION '/home/bchenba/SparkSQLRunner/Data/google.csv';
create table wiki
(
    src integer,
    dst integer
) USING CSV LOCATION '/home/bchenba/SparkSQLRunner/Data/wiki.csv';
