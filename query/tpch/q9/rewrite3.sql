create or replace view aggView659982794830351679 as select n_nationkey as v13, n_name as v49 from nation as nation;
create or replace view aggView4364935927468125314 as select o_year as v39, o_orderkey as v38 from orderswithyear as orderswithyear;
create or replace view aggView110252626232262950 as select ps_partkey as v33, ps_suppkey as v10, ps_supplycost as v36 from partsupp as partsupp;
create or replace view aggJoin4605137336844344129 as select l_orderkey as v38, l_partkey as v33, l_suppkey as v10, l_quantity as v21, l_extendedprice as v22, l_discount as v23, v36 from lineitem as lineitem, aggView110252626232262950 where lineitem.l_partkey=aggView110252626232262950.v33 and lineitem.l_suppkey=aggView110252626232262950.v10;
create or replace view aggView4981235765484758376 as select p_partkey as v33 from part as part where p_name LIKE '%green%';
create or replace view aggJoin4079655352346067574 as select v38, v10, v21, v22, v23, v36 from aggJoin4605137336844344129 join aggView4981235765484758376 using(v33);
create or replace view semiJoinView4192477368330954489 as select s_suppkey as v10, s_nationkey as v13 from supplier AS supplier where (s_nationkey) in (select v13 from aggView659982794830351679);
create or replace view semiJoinView2403943016395373596 as select v38, v10, v21, v36, (v22 * (1 - v23)) as v54 from aggJoin4079655352346067574 where (v10) in (select v10 from semiJoinView4192477368330954489);
create or replace view semiJoinView1031147033717388098 as select distinct v39, v38 from aggView4364935927468125314 where (v38) in (select v38 from semiJoinView2403943016395373596);
create or replace view semiEnum7870301383092800892 as select distinct v10, v21, v39, v36, v54 from semiJoinView1031147033717388098 join semiJoinView2403943016395373596 using(v38);
create or replace view semiEnum272064558050515044 as select distinct v21, v39, v36, v13, v54 from semiEnum7870301383092800892 join semiJoinView4192477368330954489 using(v10);
create or replace view semiEnum4793168927829201930 as select v21, v39, v49, v36, v54 from semiEnum272064558050515044 join aggView659982794830351679 using(v13);
select v49, v39, SUM(v54) as v54, SUM((v36 * v21)) as v55 from semiEnum4793168927829201930 group by v49, v39;

