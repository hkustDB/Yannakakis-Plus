create or replace view aggView3978310740192842957 as select src as v8, SUM(dst) as v11, COUNT(*) as annot from Graph as g5 group by src;
create or replace view aggJoin414502216975255726 as select src as v6, dst as v8, v11, annot from Graph as g4, aggView3978310740192842957 where g4.dst=aggView3978310740192842957.v8;
create or replace view aggView4571108776148942170 as select dst as v2, COUNT(*) as annot from Graph as g1 group by dst;
create or replace view aggJoin556896954014673941 as select src as v2, dst as v4, annot from Graph as g2, aggView4571108776148942170 where g2.src=aggView4571108776148942170.v2;
create or replace view semiJoinView734647354410523086 as select src as v4, dst as v6 from Graph AS g3 where (src) in (select v4 from aggJoin556896954014673941);
create or replace view semiJoinView7625059380067687361 as select v6, v8, v11, annot from aggJoin414502216975255726 where (v6) in (select v6 from semiJoinView734647354410523086);
# +. SemiEnumerate
create or replace view semiEnum2415844611545237546 as select annot, v8, v4, v11 from semiJoinView7625059380067687361 join semiJoinView734647354410523086 using(v6);
# +. SemiEnumerate
create or replace view semiEnum6054060206801095505 as select v8, v11*aggJoin556896954014673941.annot as v11, v2 from semiEnum2415844611545237546 join aggJoin556896954014673941 using(v4);
select v2,v8,SUM(v11) as v11 from semiEnum6054060206801095505 group by v2, v8;
