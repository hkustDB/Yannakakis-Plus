SELECT SUM(l.extendedprice*l.discount) AS revenue
FROM   lineitem l
WHERE  l.shipdate >= 757353600 
  AND  l.shipdate < 788889600 
  AND  (l.discount BETWEEN (0.06 - 0.01) AND (0.06 + 0.01)) 
  AND  l.quantity < 24