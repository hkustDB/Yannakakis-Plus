SELECT SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM lineitem, part
WHERE p_partkey = l_partkey
  AND p_brand = 'Brand#12'
  AND p_container IN ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG')
  AND l_quantity >= 3 AND l_quantity <= 3 + 10 
  AND p_size BETWEEN 1 AND 5
  AND l_shipmode IN ('AIR', 'AIR REG')
  AND l_shipinstruct = 'DELIVER IN PERSON'