drop view if exists c_new cascade;
drop view if exists o_new cascade;
drop view if exists s_new cascade;
create or replace view c_new as select n_name as cust_nation, c_custkey from customer, nation where n_name = 'GERMANY' and c_nationkey = n_nationkey;
create or replace view o_new as select o_orderkey, cust_nation from orders, c_new where o_custkey = c_new.c_custkey;
create or replace view s_new as select s_suppkey, n_name as supp_nation from supplier, nation where n_name = 'FRANCE' and s_nationkey = n_nationkey;
select supp_nation, cust_nation, EXTRACT(YEAR FROM l_shipdate) as l_year, SUM(l_extendedprice * (1 - l_discount)) as revenue from lineitem, o_new, s_new where l_orderkey = o_new.o_orderkey and l_suppkey = s_new.s_suppkey and l_shipdate >= DATE '1995-01-01' and l_shipdate <= DATE '1996-12-31' group by supp_nation, cust_nation, l_year;