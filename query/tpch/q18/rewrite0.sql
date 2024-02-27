create or replace view aggJoin5654120506208677286 as select c_name as v2, c_custkey as v1 from customer as customer;
create or replace view aggJoin860646772278139173 as select o_totalprice as v12, o_custkey as v1, o_orderkey as v9, o_orderdate as v13 from orders as orders;
create or replace view aggView8384609897005654718 as select l_orderkey as v9, SUM(l_quantity) as v35 from lineitem as lineitem group by l_orderkey;
create or replace view aggJoin8926307476294101666 as select v1_orderkey as v9, v35 from q18_inner as q18_inner, aggView8384609897005654718 where q18_inner.v1_orderkey=aggView8384609897005654718.v9;
create or replace view semiJoinView5389216024694668916 as select v9, v1, v12, v13 from aggJoin860646772278139173 where (v9) in (select v9 from aggJoin8926307476294101666);
create or replace view semiJoinView4763058209741765234 as select v9, v1, v12, v13 from semiJoinView5389216024694668916 where (v1) in (select v1 from aggJoin5654120506208677286);
create or replace view semiEnum9112254652157910017 as select v2, v1, v12, v9, v13 from semiJoinView4763058209741765234 join aggJoin5654120506208677286 using(v1);
select v1,v2,v9,v12,v13,sum(v35) as v35 from semiEnum9112254652157910017 join aggJoin8926307476294101666 using(v9) group by v2, v1, v12, v9, v13;
