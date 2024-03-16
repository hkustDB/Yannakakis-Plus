CREATE TABLE IF NOT EXISTS nation ( 
  n_nationkey int NOT NULL COMMENT '',
  n_name varchar NOT NULL COMMENT '',
  n_regionkey int NOT NULL COMMENT '',
  n_comment varchar COMMENT '',
  `dummy` varchar   
) DISTRIBUTED BY BROADCAST;

CREATE TABLE IF NOT EXISTS region ( 
  r_regionkey int NOT NULL COMMENT '',
  r_name varchar NOT NULL COMMENT '',
  r_comment varchar COMMENT '',
  dummy varchar
) DISTRIBUTED BY BROADCAST;

CREATE TABLE IF NOT EXISTS part (
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

CREATE TABLE IF NOT EXISTS supplier (  
  s_suppkey int NOT NULL COMMENT '',
  s_name varchar NOT NULL COMMENT '',
  s_address varchar NOT NULL COMMENT '',
  s_nationkey int NOT NULL COMMENT '',
  s_phone varchar NOT NULL COMMENT '',
  s_acctbal decimal(15,2) NOT NULL COMMENT '',
  s_comment varchar NOT NULL COMMENT '',
  dummy varchar
) DISTRIBUTED BY HASH  (s_suppkey);

CREATE TABLE IF NOT EXISTS partsupp (  
  ps_partkey int NOT NULL COMMENT '',
  ps_suppkey int NOT NULL COMMENT '',
  ps_availqty int NOT NULL COMMENT '',
  ps_supplycost decimal(15,2) NOT NULL COMMENT '',
  ps_comment varchar NOT NULL COMMENT '',
  dummy varchar
) DISTRIBUTED BY HASH  (ps_partkey);

CREATE TABLE IF NOT EXISTS customer (  
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

CREATE TABLE IF NOT EXISTS orders (  
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

CREATE TABLE IF NOT EXISTS lineitem ( 
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

submit job insert overwrite into nation select * from oss_nation;
submit job insert overwrite into region select * from oss_region;
submit job insert overwrite into part select * from oss_part;
submit job insert overwrite into supplier select * from oss_supplier;
submit job insert overwrite into partsupp select * from oss_partsupp;
submit job insert overwrite into customer select * from oss_customer;
submit job insert overwrite into orders select * from oss_orders;
submit job insert overwrite into lineitem select * from oss_lineitem;

ANALYZE TABLE customer UPDATE HISTOGRAM;
ANALYZE TABLE lineitem UPDATE HISTOGRAM;
ANALYZE TABLE nation UPDATE HISTOGRAM;
ANALYZE TABLE orders UPDATE HISTOGRAM;
ANALYZE TABLE part UPDATE HISTOGRAM;
ANALYZE TABLE partsupp UPDATE HISTOGRAM;
ANALYZE TABLE region UPDATE HISTOGRAM;
ANALYZE TABLE supplier UPDATE HISTOGRAM;

create or replace view q2_inner as
SELECT ps_partkey as v1_partkey, MIN(ps_supplycost) as v1_supplycost_min
FROM partsupp, supplier, nation, region
WHERE s_suppkey = ps_suppkey
  AND s_nationkey = n_nationkey
  AND n_regionkey = r_regionkey
  AND r_name = 'EUROPE'
GROUP BY ps_partkey;

create or replace view orderswithyear as select orders.*, year(o_orderdate) as o_year from orders;

create or replace view revenue0 (supplier_no, total_revenue) as select l_suppkey, sum(l_extendedprice * (1 - l_discount))
from lineitem
where l_shipdate >= DATE '1995-02-01' and l_shipdate < DATE '1995-05-01'
group by l_suppkey;

create or replace view q15_inner as select max(total_revenue) as max_tr from revenue0;

create view q17_inner as select l_partkey as v1_partkey, 0.2 * AVG(l_quantity) as v1_quantity_avg from lineitem l2 group by l_partkey;

create or replace view q18_inner as select l_orderkey as v1_orderkey from lineitem l2 group by l_orderkey having sum(l_quantity) > 312;

create or replace view q20_inner1 as SELECT p_partkey as v1_partkey FROM part WHERE p_name LIKE 'forest%';

create or replace view q20_inner2 as 
SELECT 0.5 * SUM(l_quantity) as v2_quantity_sum FROM lineitem, partsupp
WHERE l_partkey = ps_partkey
	AND l_suppkey = ps_suppkey
	AND l_shipdate >= DATE '1994-01-01'
	AND l_shipdate < DATE '1995-01-01';