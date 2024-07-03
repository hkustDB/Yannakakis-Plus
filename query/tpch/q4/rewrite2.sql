create or replace view aggView7937152583802539086 as select o_orderkey as v10, o_orderpriority as v6 from orders as orders where o_orderdate>=DATE '1993-07-01' and o_orderdate<DATE '1993-10-01';
select v6,COUNT(*) as v26 from lineitem as lineitem, aggView7937152583802539086 where lineitem.l_orderkey=aggView7937152583802539086.v10 and l_commitdate<l_receiptdate group by v6;
