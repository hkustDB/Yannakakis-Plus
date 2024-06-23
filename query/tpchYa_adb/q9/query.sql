create or replace view as SELECT n_name, o_year, SUM(l_extendedprice * (1 - l_discount)) as sum_total, SUM(ps_supplycost * l_quantity) AS cost
FROM part, supplier, lineitem, partsupp, orderswithyear, nation
WHERE s_suppkey = l_suppkey
	AND ps_suppkey = l_suppkey
	AND ps_partkey = l_partkey
	AND p_partkey = l_partkey
	AND o_orderkey = l_orderkey
	AND s_nationkey = n_nationkey
	AND p_name LIKE '%green%'
GROUP BY n_name, o_year;
/*+QUERY_TIMEOUT=86400000*/select sum(n_name), sum(o_year), sum(sum_total), sum(cost) from res;