SELECT s_suppkey,
       s_name,
       s_address,
       s_phone,
       total_revenue
FROM supplier,
     view1,
     view2
WHERE s_suppkey = l_suppkey
  AND total_revenue = v2_total_revenue_max