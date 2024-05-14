create or replace view aggView438922793754595364 as select c_custkey as v1 from customer as customer where c_mktsegment= 'BUILDING';
create or replace view aggJoin6532883507121334891 as select o_orderkey as v18, o_orderdate as v13, o_shippriority as v16 from orders as orders, aggView438922793754595364 where orders.o_custkey=aggView438922793754595364.v1 and o_orderdate<DATE '1995-03-15';
create or replace view aggView9130570204323113003 as select v16, v13, v18, COUNT(*) as annot from aggJoin6532883507121334891 group by v16,v13,v18;
create or replace view aggView7726742423112935842 as select l_orderkey as v18, SUM(l_extendedprice * (1 - l_discount)) as v35 from lineitem as lineitem where l_shipdate>DATE '1995-03-15' group by l_orderkey;
create or replace view aggJoin7789159958751441495 as select v16, v13, v18, v35 * aggView9130570204323113003.annot as v35 from aggView9130570204323113003 join aggView7726742423112935842 using(v18);
select v18,v35,v13,v16 from aggJoin7789159958751441495;
