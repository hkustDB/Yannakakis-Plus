SELECT  s.name, COUNT(*) AS numwait
FROM    supplier s, lineitem l1, lineitem l2, orders o, nation n
WHERE   s.suppkey = l1.suppkey
  AND   o.orderkey = l1.orderkey
  AND   o.orderstatus = 'F'
  AND   l1.receiptdate > l1.commitdate
	AND   l2.orderkey = l1.orderkey
	AND   l2.suppkey <> l1.suppkey
	# AND   l1.orderkey not in (select orderkey from inner)
GROUP BY s.name