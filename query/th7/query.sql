SELECT n1.name AS supp_nation, n2.name AS cust_nation, l_year,
       sum(l.extendedprice * (1 - l.discount)) AS revenue
FROM supplier s, lineitemwithyear l, orders o, customer c, nation n1, nation n2
WHERE s.suppkey = l.suppkey
  AND o.orderkey = l.orderkey
  AND c.custkey = o.custkey
  AND s.nationkey = n1.nationkey 
  AND c.nationkey = n2.nationkey 
  AND n1.name = 'FRANCE' 
  AND n2.name = 'GERMANY'
  AND (l.shipdate BETWEEN 788889600 AND 851961600)
GROUP BY n1.name, n2.name, l_year