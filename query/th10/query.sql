SELECT  c.custkey, c.name, c.acctbal, n.name, c.address, c.phone, c.`comment`,
        SUM(l.extendedprice * (1 - l.discount)) AS revenue
FROM    customer c, orders o, lineitem l, nation n
WHERE   c.custkey = o.custkey
  AND   l.orderkey = o.orderkey
  AND   o.orderdate >= 749404800 
  AND   o.orderdate < 757353600 
  AND   l.returnflag = 'R'
  AND   c.nationkey = n.nationkey
GROUP BY c.custkey, c.name, c.acctbal, c.phone, n.name, c.address, c.`comment`