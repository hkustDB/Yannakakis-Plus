create or replace view r_trun as select r_regionkey from region where r_name = 'ASIA';
create or replace view n_new as select n_name, n_nationkey from nation, r_trun where n_regionkey = r_regionkey;
create or replace view c_new as select c_custkey, n_name, n_nationkey from n_new, customer where c_nationkey = n_nationkey;
create or replace view o_trun as select o_custkey, o_orderkey from orders where o_orderdate >= DATE '1994-01-01' and o_orderdate < DATE '1995-01-01';
create or replace view o_new as select o_orderkey, n_nationkey, n_name from c_new, o_trun where c_custkey = o_custkey;
create or replace view l_new as select l_extendedprice * (1 - l_discount) as agg, s_nationkey, l_orderkey from lineitem, supplier where l_suppkey = s_suppkey;
select n_name, sum(agg) as agg from o_new, l_new where l_orderkey = o_orderkey and s_nationkey = n_nationkey group by n_name;