create or replace view aggView6367540409706609393 as select n_name as v35, n_nationkey as v4 from nation as nation;
create or replace view aggView4682377113506299348 as select c_address as v3, c_comment as v8, c_nationkey as v4, c_custkey as v1, c_acctbal as v6, c_phone as v5, c_name as v2 from customer as customer;
create or replace view aggView6135338864885608995 as select l_orderkey as v18, SUM(l_extendedprice * (1 - l_discount)) as v39, COUNT(*) as annot from lineitem as lineitem where l_returnflag= 'R' group by l_orderkey;
create or replace view aggJoin8643538614732192620 as select o_custkey as v1, o_orderdate as v13, v39, annot from orders as orders, aggView6135338864885608995 where orders.o_orderkey=aggView6135338864885608995.v18 and o_orderdate>=DATE '1993-10-01' and o_orderdate<DATE '1994-01-01';
create or replace view aggView577559747962429385 as select v1, SUM(v39) as v39, SUM(annot) as annot from aggJoin8643538614732192620 group by v1;
create or replace view aggJoin5965195301941314531 as select v3, v8, v4, v1, v6, v5, v2, v39, annot from aggView4682377113506299348 join aggView577559747962429385 using(v1);
create or replace view semiJoinView3438360464487712057 as select distinct v35, v4 from aggView6367540409706609393 where (v4) in (select (v4) from aggJoin5965195301941314531);
create or replace view semiEnum2138964949135768348 as select v3, v8, v39, v1, v6, annot, v35, v5, v2 from semiJoinView3438360464487712057 join aggJoin5965195301941314531 using(v4);
select v1,v2,SUM(v39) as v39,v6,v35,v3,v5,v8 from semiEnum2138964949135768348 group by v1, v2, v6, v5, v35, v3, v8;
