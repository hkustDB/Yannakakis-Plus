SELECT c.name, c.custkey, o.orderkey, o.orderdate, o.totalprice, 
       sum(l.quantity) AS query18
FROM customer c, orders o, lineitem l
WHERE c.custkey = o.custkey AND o.orderkey = l.orderkey
GROUP BY c.name, c.custkey, o.orderkey, o.orderdate, o.totalprice
