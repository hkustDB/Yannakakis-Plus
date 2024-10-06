create or replace view aggView4175807585068549620 as select src as v6, SUM(dst) as v11, COUNT(*) as annot from Graph as g4 group by src;
create or replace view aggJoin3314692251595276601 as select src as v4, dst as v6, v11, annot from Graph as g3, aggView4175807585068549620 where g3.dst=aggView4175807585068549620.v6;
create or replace view aggView205492719017449698 as select v4, SUM(v11) as v11, SUM(v6 * annot) as v10, SUM(annot) as annot from aggJoin3314692251595276601 group by v4;
create or replace view aggJoin8733448582356401994 as select src as v2, v11, v10, annot from Graph as g2, aggView205492719017449698 where g2.dst=aggView205492719017449698.v4;
create or replace view aggView2149725182565016536 as select v2, SUM(v11) as v11, SUM(v10) as v10, SUM(annot) as annot from aggJoin8733448582356401994 group by v2;
create or replace view aggView7179948322801388916 as select dst as v2, SUM(src) as v12, COUNT(*) as annot from Graph as g1 group by dst;
create or replace view aggJoin1225136450080010962 as select v2, v11*aggView7179948322801388916.annot as v11, v10*aggView7179948322801388916.annot as v10, aggView2149725182565016536.annot * aggView7179948322801388916.annot as annot, v12 * aggView2149725182565016536.annot as v12 from aggView2149725182565016536 join aggView7179948322801388916 using(v2);
select v2,annot as v9,v10,v11/annot as v11,v12/annot as v12 from aggJoin1225136450080010962;
