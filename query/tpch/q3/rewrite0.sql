create or replace view aggView7402404418734119223 as select c_custkey as v1 from customer as customer where c_mktsegment= 'BUILDING';
create or replace view aggJoin1946689720926186427 as select o_orderkey as v18, o_orderdate as v13, o_shippriority as v16 from orders as orders, aggView7402404418734119223 where orders.o_custkey=aggView7402404418734119223.v1 and o_orderdate<DATE '1995-03-15';
create or replace view aggView3574237209173493240 as select v16, v13, v18, COUNT(*) as annot from aggJoin1946689720926186427 group by v16,v13,v18;
create or replace view aggView5835126481766395921 as select l_orderkey as v18, SUM(l_extendedprice * (1 - l_discount)) as v35 from lineitem as lineitem where l_shipdate>DATE '1995-03-15' group by l_orderkey;
create or replace view aggJoin996413649886021707 as select v16, v13, v18, v35 * aggView3574237209173493240.annot as v35 from aggView3574237209173493240 join aggView5835126481766395921 using(v18);
create or replace view res as select v18, v35, v13, v16 from aggJoin996413649886021707;
select sum(v18), sum(v35), sum(v13), sum(v16) from res;