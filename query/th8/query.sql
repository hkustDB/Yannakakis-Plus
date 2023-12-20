SELECT n2.name,
       o_year,
       l.extendedprice * (1-l.discount) AS volume
FROM   part p, supplier s, lineitem l, orderswithyear o, customer c, nation n1,
       nation n2, region r
WHERE  p.partkey = l.partkey
  AND  s.suppkey = l.suppkey
  AND  l.orderkey = o.orderkey
  AND  o.custkey = c.custkey
  AND  c.nationkey = n1.nationkey 
  AND  n1.regionkey = r.regionkey 
  AND  r.name = 'AMERICA'
  AND  s.nationkey = n2.nationkey
  AND  (o.orderdate BETWEEN 788889600 AND 851961600)
  AND  p.type = 'ECONOMY ANODIZED STEEL'
