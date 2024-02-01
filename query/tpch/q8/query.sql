SELECT o_year, 
	SUM(CASE WHEN n2.n_name = 'BRAZIL' THEN l_extendedprice * (1 - l_discount) ELSE 0 END) / SUM(l_extendedprice * (1 - l_discount)) AS mkt_share
FROM part, supplier, lineitem, orderswithyear, customer, nation n1, nation n2, region
WHERE p_partkey = l_partkey
	AND s_suppkey = l_suppkey
  	AND l_orderkey = o_orderkey
  	AND o_custkey = c_custkey
	AND c_nationkey = n1.n_nationkey
  	AND n1.n_regionkey = r_regionkey
  	AND r_name = 'AMERICA'
  	AND s_nationkey = n2.n_nationkey
  	AND o_orderdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
  	AND p_type = 'ECONOMY ANODIZED STEEL'
GROUP BY o_year