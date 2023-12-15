SELECT s.acctbal, s.name as sname, n.name as nname, p.partkey, p.mfgr, s.address, s.phone, s.`comment`, ps.supplycost
FROM part p, supplier s, partsupp ps, nation n, region r
WHERE p.partkey = ps.partkey
  AND s.suppkey = ps.suppkey
  AND p.size = 15
  AND (p.type LIKE '%BRASS')
  AND s.nationkey = n.nationkey
  AND n.regionkey = r.regionkey
  AND r.name = 'EUROPE'