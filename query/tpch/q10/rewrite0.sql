create or replace view aggJoin4248808950401377928 as select c_address as v3, c_custkey as v1, c_acctbal as v6, c_nationkey as v4, c_name as v2, c_comment as v8, c_phone as v5 from customer as customer;
create or replace view aggJoin7463873462366400880 as select n_name as v35, n_nationkey as v4 from nation as nation;
create or replace view aggView6448786950626730063 as select l_orderkey as v18, SUM(l_extendedprice * (1 - l_discount)) as v39 from lineitem as lineitem where l_returnflag= 'R' group by l_orderkey;
create or replace view aggJoin5919051027126610214 as select o_custkey as v1, v39 from orders as orders, aggView6448786950626730063 where orders.o_orderkey=aggView6448786950626730063.v18 and o_orderdate>=DATE '1993-10-01' and o_orderdate<DATE '1994-01-01';
create or replace view aggView840863631992997695 as select v1, SUM(v39) as v39 from aggJoin5919051027126610214 group by v1;
create or replace view aggJoin329168676591820320 as select v1, v2, v3, v4, v5, v6, v8, v39 from aggJoin4248808950401377928 join aggView840863631992997695 using(v1);
create or replace view semiJoinView2024056965438754306 as select v1, v2, v3, v4, v5, v6, v8, v39 from aggJoin329168676591820320 where (v4) in (select v4 from aggJoin7463873462366400880);
create or replace view semiEnum3794515881919919911 as select v3, v39, v1, v6, v2, v8, v5, v35 from semiJoinView2024056965438754306 join aggJoin7463873462366400880 using(v4);
select v1,v2,v6,v5,v35,v3,v8,SUM(v39) as v39 from semiEnum3794515881919919911 group by v1, v2, v6, v5, v35, v3, v8;
