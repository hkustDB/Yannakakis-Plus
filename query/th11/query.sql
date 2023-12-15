SELECT ps.partkey, sum(ps.supplycost * ps.availqty) AS avgcost
FROM  partsupp ps, supplier s, nation n
WHERE ps.suppkey = s.suppkey
  AND s.nationkey = n.nationkey
  AND n.name = 'GERMANY'
GROUP BY ps.partkey