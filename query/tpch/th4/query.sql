SELECT o_orderpriority, COUNT(*) AS order_count
FROM orders, view1
WHERE o_orderdate >= DATE '1993-07-01'
  AND o_orderdate < DATE '1993-10-01'
  AND v1_orderkey_distinct = o_orderkey
GROUP BY o_orderpriority