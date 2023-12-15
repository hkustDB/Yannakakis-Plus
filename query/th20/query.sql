SELECT s.name, s.address 
FROM supplier s, nation n, partsupp ps, lineitem l, part p
WHERE s.suppkey = ps.suppkey
	AND ps.partkey = p.partkey
	AND p.name like 'forest%'
	AND l.partkey = ps.partkey
    AND l.suppkey = ps.suppkey
    AND l.shipdate >= 757353600 
    AND l.shipdate < 788889600
	AND s.nationkey = n.nationkey
	AND n.name = 'CANADA'