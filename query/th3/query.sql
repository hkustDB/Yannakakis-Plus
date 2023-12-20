SELECT ORDERS.orderkey,
       ORDERS.orderdate,
       ORDERS.shippriority,
       SUM(extendedprice * (1 - discount)) AS query3
FROM   CUSTOMER, ORDERS, LINEITEM
WHERE  CUSTOMER.mktsegment = 'BUILDING'
  AND  ORDERS.custkey = CUSTOMER.custkey
  AND  LINEITEM.orderkey = ORDERS.orderkey
  AND  ORDERS.orderdate < 795196800 
  AND  LINEITEM.shipdate > 795196800
GROUP BY ORDERS.orderkey, ORDERS.orderdate, ORDERS.shippriority