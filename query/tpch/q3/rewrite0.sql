create or replace view aggView2790820673521399856 as select c_custkey as v1, COUNT(*) as annot from customer as customer where c_mktsegment= 'BUILDING' group by c_custkey;
create or replace view aggJoin9170582986573274303 as select o_orderkey as v18, o_orderdate as v13, o_shippriority as v16, annot from orders as orders, aggView2790820673521399856 where orders.o_custkey=aggView2790820673521399856.v1 and o_orderdate<DATE '1995-03-15';
create or replace view aggView4490698852044072555 as select v13, v18, v16, SUM(annot) as annot from aggJoin9170582986573274303 group by v13,v18,v16;
create or replace view aggJoin2980646461768795184 as select v18, v13, v16, annot from aggView4490698852044072555;
create or replace view aggView4896665838770748571 as select l_orderkey as v18, SUM(l_extendedprice * (1 - l_discount)) as v35 from lineitem as lineitem where l_shipdate>DATE '1995-03-15' group by l_orderkey;
create or replace view aggJoin5268397322597439389 as select v18, v13, v16, v35 * aggJoin2980646461768795184.annot as v35 from aggJoin2980646461768795184 join aggView4896665838770748571 using(v18);
select v18,v13,v16,v35 from aggJoin5268397322597439389;
