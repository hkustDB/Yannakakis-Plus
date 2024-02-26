drop table if exists nation;
CREATE TABLE NATION  ( N_NATIONKEY  INTEGER NOT NULL,
                            N_NAME       CHAR(25) NOT NULL,
                            N_REGIONKEY  INTEGER NOT NULL,
                            N_COMMENT    VARCHAR(152));
COPY NATION FROM '/home/bchenba/TPC-H/1T/nation.tbl' ( DELIMITER '|' );

drop table if exists region;
CREATE TABLE REGION  ( R_REGIONKEY  INTEGER NOT NULL,
                            R_NAME       CHAR(25) NOT NULL,
                            R_COMMENT    VARCHAR(152));
COPY REGION FROM '/home/bchenba/TPC-H/1T/region.tbl' ( DELIMITER '|' );

drop table if exists part;
CREATE TABLE PART  ( P_PARTKEY     INTEGER NOT NULL,
                          P_NAME        VARCHAR(55) NOT NULL,
                          P_MFGR        CHAR(25) NOT NULL,
                          P_BRAND       CHAR(10) NOT NULL,
                          P_TYPE        VARCHAR(25) NOT NULL,
                          P_SIZE        INTEGER NOT NULL,
                          P_CONTAINER   CHAR(10) NOT NULL,
                          P_RETAILPRICE DECIMAL(15,2) NOT NULL,
                          P_COMMENT     VARCHAR(23) NOT NULL );
COPY PART FROM '/home/bchenba/TPC-H/1T/part.tbl' ( DELIMITER '|' );

drop table if exists supplier;
CREATE TABLE SUPPLIER ( S_SUPPKEY     INTEGER NOT NULL,
                             S_NAME        CHAR(25) NOT NULL,
                             S_ADDRESS     VARCHAR(40) NOT NULL,
                             S_NATIONKEY   INTEGER NOT NULL,
                             S_PHONE       CHAR(15) NOT NULL,
                             S_ACCTBAL     DECIMAL(15,2) NOT NULL,
                             S_COMMENT     VARCHAR(101) NOT NULL);
COPY SUPPLIER FROM '/home/bchenba/TPC-H/1T/supplier.tbl' ( DELIMITER '|' );

drop table if exists partsupp;
CREATE TABLE PARTSUPP ( PS_PARTKEY     INTEGER NOT NULL,
                             PS_SUPPKEY     INTEGER NOT NULL,
                             PS_AVAILQTY    INTEGER NOT NULL,
                             PS_SUPPLYCOST  DECIMAL(15,2)  NOT NULL,
                             PS_COMMENT     VARCHAR(199) NOT NULL );
COPY PARTSUPP FROM '/home/bchenba/TPC-H/1T/partsupp.tbl' ( DELIMITER '|' );

drop table if exists customer;
CREATE TABLE CUSTOMER ( C_CUSTKEY     INTEGER NOT NULL,
                             C_NAME        VARCHAR(25) NOT NULL,
                             C_ADDRESS     VARCHAR(40) NOT NULL,
                             C_NATIONKEY   INTEGER NOT NULL,
                             C_PHONE       CHAR(15) NOT NULL,
                             C_ACCTBAL     DECIMAL(15,2)   NOT NULL,
                             C_MKTSEGMENT  CHAR(10) NOT NULL,
                             C_COMMENT     VARCHAR(117) NOT NULL);
COPY CUSTOMER FROM '/home/bchenba/TPC-H/1T/customer.tbl' ( DELIMITER '|' );

drop table if exists orders;
CREATE TABLE ORDERS  ( O_ORDERKEY       INTEGER NOT NULL,
                           O_CUSTKEY        INTEGER NOT NULL,
                           O_ORDERSTATUS    CHAR(1) NOT NULL,
                           O_TOTALPRICE     DECIMAL(15,2) NOT NULL,
                           O_ORDERDATE      DATE NOT NULL,
                           O_ORDERPRIORITY  CHAR(15) NOT NULL,  
                           O_CLERK          CHAR(15) NOT NULL, 
                           O_SHIPPRIORITY   INTEGER NOT NULL,
                           O_COMMENT        VARCHAR(79) NOT NULL);
COPY ORDERS FROM '/home/bchenba/TPC-H/1T/orders.tbl' ( DELIMITER '|' );

drop table if exists lineitem;
CREATE TABLE LINEITEM ( L_ORDERKEY    INTEGER NOT NULL,
                             L_PARTKEY     INTEGER NOT NULL,
                             L_SUPPKEY     INTEGER NOT NULL,
                             L_LINENUMBER  INTEGER NOT NULL,
                             L_QUANTITY    DECIMAL(15,2) NOT NULL,
                             L_EXTENDEDPRICE  DECIMAL(15,2) NOT NULL,
                             L_DISCOUNT    DECIMAL(15,2) NOT NULL,
                             L_TAX         DECIMAL(15,2) NOT NULL,
                             L_RETURNFLAG  CHAR(1) NOT NULL,
                             L_LINESTATUS  CHAR(1) NOT NULL,
                             L_SHIPDATE    DATE NOT NULL,
                             L_COMMITDATE  DATE NOT NULL,
                             L_RECEIPTDATE DATE NOT NULL,
                             L_SHIPINSTRUCT CHAR(25) NOT NULL,
                             L_SHIPMODE     CHAR(10) NOT NULL,
                             L_COMMENT      VARCHAR(44) NOT NULL);
COPY LINEITEM FROM '/home/bchenba/TPC-H/1T/lineitem.tbl' ( DELIMITER '|' );

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