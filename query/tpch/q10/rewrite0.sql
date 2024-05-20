drop view if exists l_new CASCADE;
drop view if exists o_new CASCADE;
drop view if exists c_new CASCADE;
create or replace view l_new as select l_orderkey, SUM(l_extendedprice * (1 - l_discount)) AS revenue from lineitem where l_returnflag = 'R' group by l_orderkey;
create or replace view o_new as select o_custkey, revenue from l_new, orders where o_orderdate >= DATE '1993-10-01' AND o_orderdate < DATE '1994-01-01' and l_orderkey = o_orderkey;
create or replace view c_new as select c_custkey, c_name, c_acctbal, n_name, c_address, c_phone, c_comment from customer, nation where c_nationkey = n_nationkey;
select c_custkey, c_name, SUM(revenue) AS revenue, c_acctbal, n_name, c_address, c_phone, c_comment from c_new, o_new where c_custkey = o_custkey group by c_custkey, c_name, c_acctbal, c_phone, n_name, c_address, c_comment;