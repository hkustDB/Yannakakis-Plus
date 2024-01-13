SELECT o_year,
       sum(case when n2.name = 'BRAZIL' then l.extendedprice * (1-l.discount) else 0 end) as mkt_share1,
			 sum(volume) as mkt_share2
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
  AND  p.type = 'ECONOMY ANODIZED STEEL';
GROUP BY o_year;