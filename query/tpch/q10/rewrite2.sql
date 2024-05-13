create or replace view aggView1561110103285769528 as select n_name as v35, n_nationkey as v4 from nation as nation;
create or replace view aggView517292355999682079 as select c_address as v3, c_comment as v8, c_nationkey as v4, c_custkey as v1, c_acctbal as v6, c_phone as v5, c_name as v2 from customer as customer;
create or replace view aggView881264002533910552 as select l_orderkey as v18, SUM(l_extendedprice * (1 - l_discount)) as v39, COUNT(*) as annot from lineitem as lineitem where l_returnflag= 'R' group by l_orderkey;
create or replace view aggJoin9059231518179647832 as select o_custkey as v1, o_orderdate as v13, v39, annot from orders as orders, aggView881264002533910552 where orders.o_orderkey=aggView881264002533910552.v18 and o_orderdate>=DATE '1993-10-01' and o_orderdate<DATE '1994-01-01';
create or replace view aggView2244440378383468882 as select v1, SUM(v39) as v39, SUM(annot) as annot from aggJoin9059231518179647832 group by v1;
create or replace view aggJoin5658215647319025037 as select v3, v8, v4, v1, v6, v5, v2, v39, annot from aggView517292355999682079 join aggView2244440378383468882 using(v1);
create or replace view semiJoinView489495600400919735 as select distinct v3, v8, v4, v1, v6, v5, v2, v39, annot from aggJoin5658215647319025037 where (v4) in (select (v4) from aggView1561110103285769528);
create or replace view semiEnum4737090270453412191 as select v3, v8, v39, v1, v6, v35, annot, v5, v2 from semiJoinView489495600400919735 join aggView1561110103285769528 using(v4);
select v1,v2,SUM(v39) as v39,v6,v35,v3,v5,v8 from semiEnum4737090270453412191 group by v1, v2, v6, v5, v35, v3, v8;
