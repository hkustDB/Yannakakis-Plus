create or replace view aggView24956324456977208 as select c_custkey as v1 from customer as customer where c_mktsegment= 'BUILDING';
create or replace view aggJoin6358666308175828894 as select o_orderkey as v18, o_orderdate as v13, o_shippriority as v16 from orders as orders, aggView24956324456977208 where orders.o_custkey=aggView24956324456977208.v1 and o_orderdate<DATE '1995-03-15';
create or replace view aggView6875964247675978466 as select v13, v16, v18, COUNT(*) as annot from aggJoin6358666308175828894 group by v13,v16,v18;
create or replace view aggView8201562683855742266 as select l_orderkey as v18, SUM(l_extendedprice * (1 - l_discount)) as v35 from lineitem as lineitem where l_shipdate>DATE '1995-03-15' group by l_orderkey;
create or replace view aggJoin9165226091108856559 as select v13, v16, v18, v35 * aggView6875964247675978466.annot as v35 from aggView6875964247675978466 join aggView8201562683855742266 using(v18);
create or replace view res as select v18, v35, v13, v16 from aggJoin9165226091108856559;
select sum(v18+v35+v13+v16) from res;