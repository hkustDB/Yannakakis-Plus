create or replace view l_new as select s_nationkey, l_orderkey, SUM(l_extendedprice * (1 - l_discount)) as agg  from supplier, lineitem where l_suppkey = s_suppkey group by s_nationkey, l_orderkey;
create or replace view o_trun as select o_custkey, o_orderkey from orders where o_orderdate >= DATE '1994-01-01' and o_orderdate < DATE '1995-01-01';
create or replace view o_new as select s_nationkey, o_custkey, sum(agg) as agg from l_new, o_trun where l_orderkey = o_orderkey group by s_nationkey, o_custkey;
create or replace view c_new as select s_nationkey, c_nationkey, sum(agg) as agg from o_new, customer where c_custkey = o_custkey group by s_nationkey, c_nationkey;
create or replace view r_trun as select r_regionkey from region where r_name = 'ASIA';
create or replace view n_new as select n_name, n_nationkey from nation, r_trun where n_regionkey = r_regionkey;
create or replace view res1 as select n_name, sum(agg) as agg from n_new, c_new where c_nationkey = n_nationkey and s_nationkey = n_nationkey group by n_name;
select sum(n_name), sum(agg) from res1;