create or replace view aggView3558683273336025440 as select n_nationkey as v13, n_name as v49 from nation as nation;
create or replace view aggView1353093918520548055 as select o_year as v39, o_orderkey as v38 from orderswithyear as orderswithyear;
create or replace view aggView8600818768516729121 as select p_partkey as v33 from part as part where p_name LIKE '%green%';
create or replace view aggJoin5356699511112416463 as select ps_partkey as v33, ps_suppkey as v10, ps_supplycost as v36 from partsupp as partsupp, aggView8600818768516729121 where partsupp.ps_partkey=aggView8600818768516729121.v33;
create or replace view aggView7726202005368222419 as select v33, v10, SUM(v36)/COUNT(*) as v36, COUNT(*) as annot from aggJoin5356699511112416463 group by v33,v10;
create or replace view aggJoin142645805947241235 as select l_orderkey as v38, l_suppkey as v10, l_quantity as v21, l_extendedprice as v22, l_discount as v23, v36, annot from lineitem as lineitem, aggView7726202005368222419 where lineitem.l_partkey=aggView7726202005368222419.v33 and lineitem.l_suppkey=aggView7726202005368222419.v10;
create or replace view semiJoinView7598216264624721424 as select s_suppkey as v10, s_nationkey as v13 from supplier AS supplier where (s_nationkey) in (select v13 from aggView3558683273336025440);
create or replace view semiJoinView7718452568949221531 as select v38, v10, v21, v36, annot, (v22 * (1 - v23)) as v54 from aggJoin142645805947241235 where (v10) in (select v10 from semiJoinView7598216264624721424);
create or replace view semiJoinView536614729096325434 as select distinct v39, v38 from aggView1353093918520548055 where (v38) in (select v38 from semiJoinView7718452568949221531);
create or replace view semiEnum2441604823094419479 as select distinct annot, v10, v21, v39, v36, v54 from semiJoinView536614729096325434 join semiJoinView7718452568949221531 using(v38);
create or replace view semiEnum6340104331415660625 as select distinct annot, v21, v39, v36, v13, v54 from semiEnum2441604823094419479 join semiJoinView7598216264624721424 using(v10);
create or replace view semiEnum2325371717529841720 as select annot, v21, v39, v49, v36, v54 from semiEnum6340104331415660625 join aggView3558683273336025440 using(v13);
select v49, v39, SUM(v54) as v54, SUM((v36 * v21)*annot) as v55 from semiEnum2325371717529841720 group by v49, v39;

