SELECT  s.s_name, COUNT(*) AS numwait
FROM    supplier, lineitem l1, lineitem l2, orders, nation
WHERE   s_suppkey = l1_suppkey
  AND   o_orderkey = l1_orderkey
  AND   o_orderstatus = 'F'
  AND   l1_receiptdate > l1_commitdate
	AND   l2_orderkey = l1_orderkey
  AND   s_nationkey = n_nationkey
  AND   n_name = 'PERU'
GROUP BY s_name