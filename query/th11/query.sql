SELECT ps_partkey, SUM(ps_supplycost * ps_availqty) AS `value`
FROM partsupp, supplier, nation
WHERE ps_suppkey = s_suppkey
  AND s_nationkey = n_nationkey
  AND n_name = 'GERMANY'
GROUP BY ps_partkey