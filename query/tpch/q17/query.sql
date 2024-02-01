SELECT SUM(l_extendedprice) / 7.0 AS avg_yearly
FROM lineitem, part, view1
WHERE p_partkey = l_partkey
  AND p_brand = 'Brand#23'
  AND p_container = 'MED BOX'
  AND l_partkey = v1_partkey
  AND l_quantity > v1_quantity_avg