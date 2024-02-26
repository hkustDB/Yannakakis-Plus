SELECT s_suppkey,
       s_name,
       s_address,
       s_phone,
       total_revenue
FROM supplier,
     revenue0, 
     q15_inner
WHERE s_suppkey = l_suppkey
  AND total_revenue = max_tr