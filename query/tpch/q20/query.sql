SELECT ps_suppkey
FROM partsupp, view1, view2
WHERE ps_partkey = v1_partkey
  AND ps_availqty > v2_quantity_sum