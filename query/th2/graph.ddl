CREATE TABLE part (
  p_partkey int,
  p_name varchar,
  p_mfgr varchar,
  p_brand varchar,
  p_type varchar,
  p_size int ,
  p_container varchar,
  p_retailprice varchar,
  p_comment varchar
) WITH (
    'path' = 'examples/data/r.dat'
);


CREATE TABLE supplier (
  s_suppkey int,
  s_name varchar,
  s_address varchar,
  s_nationkey int,
  s_phone varchar,
  s_acctbal varchar,
  s_comment varchar
) WITH (
    'path' = 'examples/data/r.dat'
);


CREATE TABLE partsupp (
  ps_partkey int,
  ps_suppkey int,
  ps_availqty int,
  ps_supplycost varchar,
  ps_comment varchar
) WITH (
    'path' = 'examples/data/r.dat'
);


CREATE TABLE nation ( 
  n_nationkey int,
  n_name varchar,
  n_regionkey int,
  n_comment varchar  
) WITH (
    'path' = 'examples/data/r.dat'
);


CREATE TABLE region (
  r_regionkey int,
  r_name varchar,
  r_comment varchar
) WITH (
    'path' = 'examples/data/r.dat'
);

