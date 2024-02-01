SELECT c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice, SUM(l_quantity)
FROM customer, orders, lineitem, view1
WHERE o_orderkey = v1_orderkey
  AND c_custkey = o_custkey
  AND o_orderkey = l_orderkey
GROUP BY c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice