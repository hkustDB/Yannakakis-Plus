create or replace view aggView3424139660629128386 as select o_year as v39, o_orderkey as v38 from orderswithyear as orderswithyear;
create or replace view aggView4473184526346284154 as select n_nationkey as v13, n_name as v49 from nation as nation;
create or replace view aggView6956017594908144201 as select p_partkey as v33 from part as part where p_name LIKE '%green%';
create or replace view aggJoin1805769673354390414 as select ps_partkey as v33, ps_suppkey as v10, ps_supplycost as v36 from partsupp as partsupp, aggView6956017594908144201 where partsupp.ps_partkey=aggView6956017594908144201.v33;
create or replace view aggView268572484044190442 as select v33, v10, SUM(v36)/COUNT(*) as v36, COUNT(*) as annot from aggJoin1805769673354390414 group by v33,v10;
create or replace view aggJoin3249170353890797654 as select l_orderkey as v38, l_suppkey as v10, l_quantity as v21, l_extendedprice as v22, l_discount as v23, v36, annot from lineitem as lineitem, aggView268572484044190442 where lineitem.l_partkey=aggView268572484044190442.v33 and lineitem.l_suppkey=aggView268572484044190442.v10;
create or replace view semiJoinView1831717733601148071 as select v38, v10, v21, v36, annot, (v22 * (1 - v23)) as v54 from aggJoin3249170353890797654 where (v38) in (select v38 from aggView3424139660629128386);
create or replace view semiJoinView3791065465932711012 as select s_suppkey as v10, s_nationkey as v13 from supplier AS supplier where (s_suppkey) in (select v10 from semiJoinView1831717733601148071);
create or replace view semiJoinView4410405359646023734 as select distinct v13, v49 from aggView4473184526346284154 where (v13) in (select v13 from semiJoinView3791065465932711012);
create or replace view semiEnum1482627174644990968 as select distinct v49, v10 from semiJoinView4410405359646023734 join semiJoinView3791065465932711012 using(v13);
create or replace view semiEnum6621779257357616124 as select distinct annot, v38, v21, v49, v36, v54 from semiEnum1482627174644990968 join semiJoinView1831717733601148071 using(v10);
create or replace view semiEnum4963546931023595819 as select annot, v21, v39, v49, v36, v54 from semiEnum6621779257357616124 join aggView3424139660629128386 using(v38);
select v49, v39, SUM(v54) as v54, SUM((v36 * v21)*annot) as v55 from semiEnum4963546931023595819 group by v49, v39;

