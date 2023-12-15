SELECT l.shipmode, SUM(CASE WHEN o.orderpriority IN ('1-URGENT', '2-HIGH') THEN 1 ELSE 0 END) AS high_line_count, SUM(CASE WHEN o.orderpriority NOT IN ('1-URGENT', '2-HIGH') THEN 1 ELSE 0 END) AS low_line_count
FROM   orders o, lineitem l
WHERE  o.orderkey = l.orderkey
  AND  (l.shipmode IN ('MAIL', 'SHIP'))
  AND  l.commitdate < l.receiptdate
  AND  l.shipdate < l.commitdate
  AND  l.receiptdate >= 757353600
  AND  l.receiptdate < 788889600
GROUP BY l.shipmode