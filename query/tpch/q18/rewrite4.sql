create or replace view bag1 as select c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice from orders, customer where c_custkey = o_custkey;
create or replace view l_agg as select l_orderkey, sum(l_quantity) as l_sum from lineitem group by l_orderkey;
create or replace view q_new as select v1_orderkey, l_sum from q18_inner, l_agg where v1_orderkey = l_orderkey;
create or replace view res as select c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice, sum(l_sum) as agg from bag1, q_new where o_orderkey = v1_orderkey group by c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice;
select sum(c_name), sum(c_custkey), sum(o_orderkey), sum(o_orderdate), sum(o_totalprice), sum(agg) from res;