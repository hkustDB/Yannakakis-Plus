create or replace view aggView1405723795792258869 as select n_nationkey as v4 from nation as nation;
create or replace view aggJoin161683584673998030 as select c_custkey as v1, c_name as v2, c_address as v3, c_phone as v5, c_acctbal as v6, c_comment as v8 from customer as customer, aggView1405723795792258869 where customer.c_nationkey=aggView1405723795792258869.v4;
create or replace view aggView1272620788725820728 as select v1, COUNT(*) as annot from aggJoin161683584673998030 group by v1;
create or replace view aggJoin6655100850374502733 as select o_orderkey as v18, o_custkey as v1, o_orderdate as v13, annot from orders as orders, aggView1272620788725820728 where orders.o_custkey=aggView1272620788725820728.v1 and o_orderdate>=DATE '1993-10-01' and o_orderdate<DATE '1994-01-01';
create or replace view aggView3095570007926919407 as select v18, SUM(annot) as annot from aggJoin6655100850374502733 group by v18;
create or replace view aggJoin3850414748620018914 as select l_extendedprice as v23, l_discount as v24, annot from lineitem as lineitem, aggView3095570007926919407 where lineitem.l_orderkey=aggView3095570007926919407.v18 and l_returnflag= 'R';
select v1,v2,SUM((v23 * (1 - v24))*annot) as v39,v6,v35,v3,v5,v8 from aggJoin3850414748620018914 group by v1, v2, v6, v5, v35, v3, v8;
