CREATE TABLE nation ( 
  n_nationkey int NOT NULL COMMENT '',
  n_name varchar NOT NULL COMMENT '',
  n_regionkey int NOT NULL COMMENT '',
  n_comment varchar COMMENT '',
  `dummy` varchar   
) DISTRIBUTED BY BROADCAST;

CREATE TABLE region ( 
  r_regionkey int NOT NULL COMMENT '',
  r_name varchar NOT NULL COMMENT '',
  r_comment varchar COMMENT '',
  dummy varchar
) DISTRIBUTED BY BROADCAST;

CREATE TABLE part (
  p_partkey int NOT NULL COMMENT '',
  p_name varchar NOT NULL COMMENT '',
  p_mfgr varchar NOT NULL COMMENT '',
  p_brand varchar NOT NULL COMMENT '',
  p_type varchar NOT NULL COMMENT '',
  p_size int NOT NULL COMMENT '',
  p_container varchar NOT NULL COMMENT '',
  p_retailprice decimal(15,2) NOT NULL COMMENT '',
  p_comment varchar NOT NULL COMMENT '',
  dummy varchar
) DISTRIBUTED BY HASH  (p_partkey);

CREATE TABLE supplier (  
  s_suppkey int NOT NULL COMMENT '',
  s_name varchar NOT NULL COMMENT '',
  s_address varchar NOT NULL COMMENT '',
  s_nationkey int NOT NULL COMMENT '',
  s_phone varchar NOT NULL COMMENT '',
  s_acctbal decimal(15,2) NOT NULL COMMENT '',
  s_comment varchar NOT NULL COMMENT '',
  dummy varchar
) DISTRIBUTED BY HASH  (s_suppkey);

CREATE TABLE partsupp (  
  ps_partkey int NOT NULL COMMENT '',
  ps_suppkey int NOT NULL COMMENT '',
  ps_availqty int NOT NULL COMMENT '',
  ps_supplycost decimal(15,2) NOT NULL COMMENT '',
  ps_comment varchar NOT NULL COMMENT '',
  dummy varchar
) DISTRIBUTED BY HASH  (ps_partkey);

CREATE TABLE customer (  
  c_custkey int NOT NULL COMMENT '',
  c_name varchar NOT NULL COMMENT '',
  c_address varchar NOT NULL COMMENT '',
  c_nationkey int NOT NULL COMMENT '',
  c_phone varchar NOT NULL COMMENT '',
  c_acctbal decimal(15,2) NOT NULL COMMENT '',
  c_mktsegment varchar NOT NULL COMMENT '',
  c_comment varchar NOT NULL COMMENT '', 
  `dummy` varchar 
) DISTRIBUTED BY HASH  (c_custkey);

CREATE TABLE orders (  
  o_orderkey bigint NOT NULL COMMENT '',
  o_custkey int NOT NULL COMMENT '',
  o_orderstatus varchar NOT NULL COMMENT '',
  o_totalprice decimal(15,2) NOT NULL COMMENT '',
  o_orderdate DATE NOT NULL COMMENT '',
  o_orderpriority varchar NOT NULL COMMENT '',
  o_clerk varchar NOT NULL COMMENT '',
  o_shippriority int NOT NULL COMMENT '',
  o_comment varchar NOT NULL COMMENT '',
  dummy varchar
) DISTRIBUTED BY HASH  (o_orderkey);

CREATE TABLE lineitem ( 
  l_orderkey bigint NOT NULL COMMENT '',
  l_partkey int NOT NULL COMMENT '',
  l_suppkey int NOT NULL COMMENT '',
  l_linenumber int NOT NULL COMMENT '',
  l_quantity decimal(15,2) NOT NULL COMMENT '',
  l_extendedprice decimal(15,2) NOT NULL COMMENT '',
  l_discount decimal(15,2) NOT NULL COMMENT '',
  l_tax decimal(15,2) NOT NULL COMMENT '',
  l_returnflag varchar NOT NULL COMMENT '',
  l_linestatus varchar NOT NULL COMMENT '',
  l_shipdate DATE NOT NULL COMMENT '',
  l_commitdate DATE NOT NULL COMMENT '',
  l_receiptdate DATE NOT NULL COMMENT '',
  l_shipinstruct varchar NOT NULL COMMENT '',
  l_shipmode varchar NOT NULL COMMENT '',
  l_comment varchar NOT NULL COMMENT '',
  dummy varchar
) DISTRIBUTED BY HASH  (l_orderkey);