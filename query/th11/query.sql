SELECT sum(ps.supplycost * ps.availqty) * 0.001 as avgcost
FROM  partsupp ps, supplier s, nation n
WHERE ps.suppkey = s.suppkey
  AND s.nationkey = n.nationkey
  AND n.name = 'GERMANY'