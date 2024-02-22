create or replace view aggView6618358420335524545 as select src as v8, SUM(dst) as v11, COUNT(*) as annot from Graph as g5 group by src;
create or replace view aggJoin8157296211805391735 as select src as v6, dst as v8, v11, annot from Graph as g4, aggView6618358420335524545 where g4.dst=aggView6618358420335524545.v8;
create or replace view aggView3711931646100939006 as select dst as v2, COUNT(*) as annot from Graph as g1 group by dst;
create or replace view aggJoin6876317309867755934 as select src as v2, dst as v4, annot from Graph as g2, aggView3711931646100939006 where g2.src=aggView3711931646100939006.v2;
create or replace view semiJoinView6607185868510904915 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select v6 from aggJoin8157296211805391735);
create or replace view semiJoinView986072034483306687 as select v4, v6 from semiJoinView6607185868510904915 where (v4) in (select v4 from aggJoin6876317309867755934);
# +. SemiEnumerate
create or replace view semiEnum8801035733831928183 as select annot, v6, v2 from semiJoinView986072034483306687 join aggJoin6876317309867755934 using(v4);
# +. SemiEnumerate
create or replace view semiEnum4862965966827737101 as select v8, v11*semiEnum8801035733831928183.annot as v11, v2 from semiEnum8801035733831928183 join aggJoin8157296211805391735 using(v6);
select v2,v8,SUM(v11) as v11 from semiEnum4862965966827737101 group by v2, v8;
