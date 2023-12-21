CREATE TABLE nation ( nationkey int NOT NULL COMMENT '',
  name varchar NOT NULL COMMENT '',
  regionkey int NOT NULL COMMENT '',
  comment varchar COMMENT '',
  `dummy` varchar   
) DISTRIBUTED BY BROADCAST;

CREATE TABLE region ( regionkey int NOT NULL COMMENT '',
  name varchar NOT NULL COMMENT '',
  comment varchar COMMENT '',
  dummy varchar
) DISTRIBUTED BY BROADCAST;


CREATE TABLE part (partkey int NOT NULL COMMENT '',
  name varchar NOT NULL COMMENT '',
  mfgr varchar NOT NULL COMMENT '',
  brand varchar NOT NULL COMMENT '',
  type varchar NOT NULL COMMENT '',
  size int NOT NULL COMMENT '',
  container varchar NOT NULL COMMENT '',
  retailprice decimal(15,2) NOT NULL COMMENT '',
  comment varchar NOT NULL COMMENT '',
  dummy varchar
) DISTRIBUTED BY HASH  (partkey);

CREATE TABLE supplier (  suppkey int NOT NULL COMMENT '',
  name varchar NOT NULL COMMENT '',
  address varchar NOT NULL COMMENT '',
  nationkey int NOT NULL COMMENT '',
  phone varchar NOT NULL COMMENT '',
  acctbal decimal(15,2) NOT NULL COMMENT '',
  comment varchar NOT NULL COMMENT '',
  dummy varchar
) DISTRIBUTED BY HASH  (suppkey);

CREATE TABLE partsupp (  partkey int NOT NULL COMMENT '',
  suppkey int NOT NULL COMMENT '',
  availqty int NOT NULL COMMENT '',
  supplycost decimal(15,2) NOT NULL COMMENT '',
  comment varchar NOT NULL COMMENT '',
  dummy varchar
) DISTRIBUTED BY HASH  (partkey);

CREATE TABLE customer (  custkey int NOT NULL COMMENT '',
  name varchar NOT NULL COMMENT '',
  address varchar NOT NULL COMMENT '',
  nationkey int NOT NULL COMMENT '',
  phone varchar NOT NULL COMMENT '',
  acctbal decimal(15,2) NOT NULL COMMENT '',
  mktsegment varchar NOT NULL COMMENT '',
  comment varchar NOT NULL COMMENT '', 
  `dummy` varchar 
) DISTRIBUTED BY HASH  (custkey);

CREATE TABLE orders (  orderkey bigint NOT NULL COMMENT '',
  custkey int NOT NULL COMMENT '',
  orderstatus varchar NOT NULL COMMENT '',
  totalprice decimal(15,2) NOT NULL COMMENT '',
  orderdate bigint NOT NULL COMMENT '',
  orderpriority varchar NOT NULL COMMENT '',
  clerk varchar NOT NULL COMMENT '',
  shippriority int NOT NULL COMMENT '',
  comment varchar NOT NULL COMMENT '',
  dummy varchar
) DISTRIBUTED BY HASH  (orderkey);

CREATE TABLE lineitem ( orderkey bigint NOT NULL COMMENT '',
  partkey int NOT NULL COMMENT '',
  suppkey int NOT NULL COMMENT '',
  linenumber int NOT NULL COMMENT '',
  quantity decimal(15,2) NOT NULL COMMENT '',
  extendedprice decimal(15,2) NOT NULL COMMENT '',
  discount decimal(15,2) NOT NULL COMMENT '',
  tax decimal(15,2) NOT NULL COMMENT '',
  returnflag varchar NOT NULL COMMENT '',
  linestatus varchar NOT NULL COMMENT '',
  shipdate bigint NOT NULL COMMENT '',
  commitdate bigint NOT NULL COMMENT '',
  receiptdate bigint NOT NULL COMMENT '',
  shipinstruct varchar NOT NULL COMMENT '',
  shipmode varchar NOT NULL COMMENT '',
  comment varchar NOT NULL COMMENT '',
  dummy varchar
) DISTRIBUTED BY HASH  (orderkey);