create or replace view aggView2505170995681704744 as select o_year as v39, o_orderkey as v38 from orderswithyear as orderswithyear;
create or replace view aggView1318548310726397363 as select n_nationkey as v13, n_name as v49 from nation as nation;
create or replace view aggView9030237068984971732 as select ps_partkey as v33, ps_suppkey as v10, ps_supplycost as v36 from partsupp as partsupp;
create or replace view aggJoin6813051044496327037 as select l_orderkey as v38, l_partkey as v33, l_suppkey as v10, l_quantity as v21, l_extendedprice as v22, l_discount as v23, v36 from lineitem as lineitem, aggView9030237068984971732 where lineitem.l_partkey=aggView9030237068984971732.v33 and lineitem.l_suppkey=aggView9030237068984971732.v10;
create or replace view aggView6037113463895370186 as select p_partkey as v33 from part as part where p_name LIKE '%green%';
create or replace view aggJoin8444515600099582550 as select v38, v10, v21, v22, v23, v36 from aggJoin6813051044496327037 join aggView6037113463895370186 using(v33);
create or replace view semiJoinView7065000066617033322 as select v38, v10, v21, v36, (v22 * (1 - v23)) as v54 from aggJoin8444515600099582550 where (v38) in (select v38 from aggView2505170995681704744);
create or replace view semiJoinView4868864826132939249 as select s_suppkey as v10, s_nationkey as v13 from supplier AS supplier where (s_suppkey) in (select v10 from semiJoinView7065000066617033322);
create or replace view semiJoinView576410822802983675 as select distinct v13, v49 from aggView1318548310726397363 where (v13) in (select v13 from semiJoinView4868864826132939249);
create or replace view semiEnum2989572044356378378 as select distinct v49, v10 from semiJoinView576410822802983675 join semiJoinView4868864826132939249 using(v13);
create or replace view semiEnum5856808991882710713 as select distinct v38, v21, v49, v36, v54 from semiEnum2989572044356378378 join semiJoinView7065000066617033322 using(v10);
create or replace view semiEnum3644526766112211514 as select v21, v39, v49, v36, v54 from semiEnum5856808991882710713 join aggView2505170995681704744 using(v38);
select v49, v39, SUM(v54) as v54, SUM((v36 * v21)) as v55 from semiEnum3644526766112211514 group by v49, v39;

