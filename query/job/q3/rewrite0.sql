create or replace view aggView2678550091307126597 as select c_custkey as v1 from customer as customer where c_mktsegment= 'BUILDING';
create or replace view aggJoin7523778419373938218 as select o_orderkey as v18, o_orderdate as v13, o_shippriority as v16 from orders as orders, aggView2678550091307126597 where orders.o_custkey=aggView2678550091307126597.v1 and o_orderdate<DATE '1995-03-15';
create or replace view aggView7749408465346073977 as select v18, v13, v16, COUNT(*) as annot from aggJoin7523778419373938218 group by v18,v13,v16;
create or replace view aggJoin4543428868837818976 as select l_orderkey as v18, l_extendedprice as v23, l_discount as v24, v13, v16, annot from lineitem as lineitem, aggView7749408465346073977 where lineitem.l_orderkey=aggView7749408465346073977.v18 and l_shipdate>DATE '1995-03-15';
select v18,SUM((v23 * (1 - v24))*annot) as v35,v13,v16 from aggJoin4543428868837818976 group by v18, v13, v16;
