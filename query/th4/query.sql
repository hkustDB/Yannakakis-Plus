SELECT o.orderpriority, COUNT(*) AS order_count
FROM   orders o, lineitem l
WHERE  o.orderdate >= 741456000 AND  o.orderdate <  749404800
	AND  l.orderkey = o.orderkey
	AND  l.commitdate < l.receiptdate
GROUP BY o.orderpriority