CREATE TABLE part (
  partkey int,
  name varchar,
  mfgr varchar,
  brand varchar,
  type varchar,
  size int ,
  container varchar,
  retailprice varchar,
  `comment` varchar
);

CREATE TABLE supplier (
  suppkey int,
  name varchar,
  address varchar,
  nationkey int,
  phone varchar,
  acctbal varchar,
  `comment` varchar
);


CREATE TABLE partsupp (
  partkey int,
  suppkey int,
  availqty int,
  supplycost varchar,
  `comment` varchar
);


CREATE TABLE nation ( 
  nationkey int,
  name varchar,
  regionkey int,
  `comment` varchar
);


CREATE TABLE region (
  regionkey int,
  name varchar,
  `comment` varchar
);

CREATE TABLE customer (  
  custkey int,
  name varchar,
  address varchar,
  nationkey int,
  phone varchar,
  acctbal decimal,
  mktsegment varchar,
  `comment` varchar
);

CREATE TABLE orders (  
  orderkey bigint,
  custkey int,
  orderstatus varchar,
  totalprice decimal,
  orderdate bigint,
  orderpriority varchar,
  clerk varchar,
  shippriority int,
  `comment` varchar
);

CREATE TABLE orderswithyear (  
  orderkey bigint,
  custkey int,
  orderstatus varchar,
  totalprice decimal,
  orderdate bigint,
  o_year int,
  orderpriority varchar,
  clerk varchar,
  shippriority int,
  `comment` varchar
);


CREATE TABLE lineitem ( 
  orderkey bigint,
  partkey int,
  suppkey int,
  linenumber int,
  quantity decimal,
  extendedprice decimal,
  discount decimal,
  tax decimal,
  returnflag varchar,
  linestatus varchar,
  shipdate bigint,
  commitdate bigint,
  receiptdate bigint,
  shipinstruct varchar,
  shipmode varchar,
  `comment` varchar
);

CREATE TABLE lineitemwithyear ( 
  orderkey bigint,
  partkey int,
  suppkey int,
  linenumber int,
  quantity decimal,
  extendedprice decimal,
  discount decimal,
  tax decimal,
  returnflag varchar,
  linestatus varchar,
  shipdate bigint,
  l_year int,
  commitdate bigint,
  receiptdate bigint,
  shipinstruct varchar,
  shipmode varchar,
  `comment` varchar
);

CREATE TABLE revenue0 (
  supplier_no int,
  total_revenue decimal
);

CREATE TABLE q15_inner (
  max_tr decimal
);


