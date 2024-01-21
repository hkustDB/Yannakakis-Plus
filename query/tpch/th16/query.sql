SELECT  p.brand, p.type, p.size, COUNT(ps.suppkey) AS supplier_cnt
FROM    partsupp ps, part p
WHERE   p.partkey = ps.partkey
  AND   p.brand <> 'Brand#45'
  AND   (p.type not like 'SMALL ANODIZED%')
  AND   (p.size in (47, 15, 37, 30, 46, 16, 18, 6))
GROUP BY p.brand, p.type, p.size