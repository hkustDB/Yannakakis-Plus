SELECT 100.00 * sum(case when p.type like 'PROMO%' then l.extendedprice * (1 - l.discount) else 0 end) / sum(l.extendedprice * (1 - l.discount)) as promo_revenue
FROM lineitem l, part p
WHERE l.partkey = p.partkey
  AND l.shipdate >= 809884800
  AND l.shipdate < 812476800