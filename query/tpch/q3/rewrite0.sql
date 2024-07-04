create or replace view aggView4611234913184884195 as select c_custkey as v1 from customer as customer where c_mktsegment= 'BUILDING';
create or replace view aggJoin3261746457186427323 as select o_orderkey as v18, o_orderdate as v13, o_shippriority as v16 from orders as orders, aggView4611234913184884195 where orders.o_custkey=aggView4611234913184884195.v1 and o_orderdate<DATE '1995-03-15';
create or replace view aggView3587955571349171707 as select v18, v16, v13, COUNT(*) as annot from aggJoin3261746457186427323 group by v18,v16,v13;
create or replace view aggJoin4762158595271567261 as select l_orderkey as v18, l_extendedprice as v23, l_discount as v24, l_shipdate as v28, v16, v13, annot from lineitem as lineitem, aggView3587955571349171707 where lineitem.l_orderkey=aggView3587955571349171707.v18 and l_shipdate>DATE '1995-03-15';
select v18,SUM((v23 * (1 - v24))*annot) as v35,v13,v16 from aggJoin4762158595271567261 group by v18, v13, v16;
