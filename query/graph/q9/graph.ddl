create table epinions
(
    src integer,
    dst integer
) USING CSV LOCATION '/PATH_TO_DATA/epinions.csv';
create table Graph
(
    src integer,
    dst integer
) USING CSV LOCATION '/PATH_TO_DATA/Graph.csv';
create table bitcoin
(
    src integer,
    dst integer,
    weight integer
) USING CSV LOCATION '/PATH_TO_DATA/bitcoin.csv';
create table dblp
(
    src integer,
    dst integer
) USING CSV LOCATION '/PATH_TO_DATA/dblp.csv';
create table google
(
    src integer,
    dst integer
) USING CSV LOCATION '/PATH_TO_DATA/google.csv';
create table wiki
(
    src integer,
    dst integer
) USING CSV LOCATION '/PATH_TO_DATA/wiki.csv';
