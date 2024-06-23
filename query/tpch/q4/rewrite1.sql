create or replace view aggView4386951755351965097 as select o_orderkey as v10, o_orderpriority as v6 from orders as orders where o_orderdate>=DATE '1993-07-01' and o_orderdate<DATE '1993-10-01';
create or replace view aggJoin8405238060296043820 as select v6 from lineitem as lineitem, aggView4386951755351965097 where lineitem.l_orderkey=aggView4386951755351965097.v10 and l_commitdate<l_receiptdate;
create or replace view res as select v6, COUNT(*) as v26 from aggJoin8405238060296043820 group by v6;
select sum(v6), sum(v26) from res;