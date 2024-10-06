SELECT l_returnflag, o_orderkey, n_name, SUM(ps_supplycost * l_quantity) AS part_cost
FROM nation_5, supplier_5, part_5, orders_5, lineitem_5, partsupp_5
WHERE o_orderdate < DATE '1996-12-31' and o_orderdate > DATE '1996-01-01' and p_name LIKE '%blue%'
  and o_orderkey = l_orderkey and ps_suppkey = l_suppkey
  and ps_partkey = l_partkey and p_partkey = l_partkey
  and s_suppkey = l_suppkey and s_nationkey = n_nationkey
GROUP BY n_name, o_orderkey, l_returnflag