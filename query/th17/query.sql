SELECT SUM(l.extendedprice) / 7.0 AS avg_yearly
FROM   lineitem l, part p
WHERE  p.partkey = l.partkey
  AND  p.brand = 'Brand#23'
  AND  p.container = 'MED BOX'