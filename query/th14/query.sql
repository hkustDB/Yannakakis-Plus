SELECT (100.00 * SUM(CASE WHEN (p.type LIKE 'PROMO%') 
                     THEN l.extendedprice * (1 - l.discount) ELSE 0 END) / 
                 sum(l.extendedprice * (1 - l.discount)) as promo_revenue
FROM lineitem l, part p
WHERE l.partkey = p.partkey
  AND l.shipdate >= 809884800
  AND l.shipdate < 812476800