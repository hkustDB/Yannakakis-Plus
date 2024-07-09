create or replace view res as SELECT c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice, SUM(l_quantity) as agg
FROM customer, orders, lineitem, q18_inner
WHERE o_orderkey = v1_orderkey
  AND c_custkey = o_custkey
  AND o_orderkey = l_orderkey
GROUP BY c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice;
select sum(c_name), sum(c_custkey), sum(o_orderkey), sum(o_orderdate), sum(o_totalprice), sum(agg) from res;