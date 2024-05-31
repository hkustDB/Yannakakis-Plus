create or replace view aggView7937152583802539086 as select o_orderkey as v10, o_orderpriority as v6 from orders as orders where o_orderdate>=DATE '1993-07-01' and o_orderdate<DATE '1993-10-01';
create or replace view aggJoin5238648630283474003 as select v6 from lineitem as lineitem, aggView7937152583802539086 where lineitem.l_orderkey=aggView7937152583802539086.v10 and l_commitdate<l_receiptdate;
select v6,COUNT(*) as v26 from aggJoin5238648630283474003 group by v6;
