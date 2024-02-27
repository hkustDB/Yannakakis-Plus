create or replace view aggJoin8553352498024694706 as select c_name as v2, c_custkey as v1 from customer as customer;
create or replace view aggJoin7978705887309047842 as select o_totalprice as v12, o_custkey as v1, o_orderkey as v9, o_orderdate as v13 from orders as orders;
create or replace view aggView7059906850342105531 as select l_orderkey as v9, SUM(l_quantity) as v35 from lineitem as lineitem group by l_orderkey;
create or replace view aggJoin8306561649814885899 as select v1_orderkey as v9, v35 from q18_inner as q18_inner, aggView7059906850342105531 where q18_inner.v1_orderkey=aggView7059906850342105531.v9;
create or replace view semiJoinView8063987127265118735 as select v9, v1, v12, v13 from aggJoin7978705887309047842 where (v9) in (select v9 from aggJoin8306561649814885899);
create or replace view semiJoinView3691319152997898796 as select v1, v2 from aggJoin8553352498024694706 where (v1) in (select v1 from semiJoinView8063987127265118735);
create or replace view semiEnum6432551149251827328 as select v12, v13, v2, v1, v9 from semiJoinView3691319152997898796 join semiJoinView8063987127265118735 using(v1);
create or replace view semiEnum4012160385568324255 as select v2, v1, v12, sum(v35) as v35, v9, v13 from semiEnum6432551149251827328 join aggJoin8306561649814885899 using(v9) group by v2, v1, v12, v9, v13;
select sum(v1),sum(v2),sum(v9),sum(v12),sum(v13),sum(v35) from semiEnum4012160385568324255;
