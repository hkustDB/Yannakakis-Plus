SELECT SUM(l.extendedprice * (1 - l.discount) ) AS revenue
FROM lineitem l, part p
WHERE p.partkey = l.partkey
  AND p.brand = 'Brand#12'
  AND ( p.container IN ( 'SM CASE', 'SM BOX', 'SM PACK', 'SM PKG') )
  AND l.quantity >= 1 AND l.quantity <= 1 + 10 
  AND ( p.size BETWEEN 1 AND 5 )
  AND (l.shipmode IN ('AIR', 'AIR REG') )
  AND l.shipinstruct = 'DELIVER IN PERSON'
