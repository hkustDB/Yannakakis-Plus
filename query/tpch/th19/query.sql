SELECT SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM lineitem, part
WHERE p_partkey = l_partkey
  AND p_brand = 'Brand#34'
  AND p_container IN ( 'LG CASE', 'LG BOX', 'LG PACK', 'LG PKG')
  AND l_quantity >= 21 AND l_quantity <= 21 + 10
  AND p_size BETWEEN 1 AND 15
  AND l_shipmode IN ('AIR', 'AIR REG')
  AND l_shipinstruct = 'DELIVER IN PERSON'
