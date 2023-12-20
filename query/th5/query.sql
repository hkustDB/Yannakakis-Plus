SELECT n.name, SUM(l.extendedprice * (1 - l.discount)) AS revenue 
FROM   customer c, orders o, lineitem l, supplier s, nation n, region r
WHERE  c.custkey = o.custkey
  AND  l.orderkey = o.orderkey
  AND  l.suppkey = s.suppkey
  AND  c.nationkey = s.nationkey 
  AND  s.nationkey = n.nationkey 
  AND  n.regionkey = r.regionkey 
  AND  r.name = 'ASIA'
  AND  o.orderdate >= 757353600 
  AND  o.orderdate < 788889600 
GROUP BY n.name