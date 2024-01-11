SELECT n1.n_name AS supp_nation, n2.n_name AS cust_nation, l_year,
       sum(l_extendedprice * (1 - l_discount)) AS revenue
FROM supplier, lineitemwithyear, orders, customer, nation n1, nation n2
WHERE s_suppkey = l_suppkey
  AND o_orderkey = l_orderkey
  AND c_custkey = o_custkey
  AND s_nationkey = n1_nationkey 
  AND c_nationkey = n2_nationkey 
  AND n1.n_name = 'FRANCE'
  AND n2.n_name = 'GERMANY'
  AND l_shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
GROUP BY n1.name, n2.name, l_year