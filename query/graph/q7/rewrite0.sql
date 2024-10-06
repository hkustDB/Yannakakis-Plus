create or replace view aggView6328439021211489000 as select src as v8, COUNT(*) as annot from Graph as g5 group by src;
create or replace view aggJoin1100051845837263031 as select src as v6, dst as v8, annot from Graph as g4, aggView6328439021211489000 where g4.dst=aggView6328439021211489000.v8;
create or replace view aggView7086711534686667371 as select v6, SUM((v8 + v6) * annot) as v12, SUM(annot) as annot from aggJoin1100051845837263031 group by v6;
create or replace view aggJoin8524680132817539633 as select src as v4, v12, annot from Graph as g3, aggView7086711534686667371 where g3.dst=aggView7086711534686667371.v6;
create or replace view aggView4644602948599854019 as select v4, SUM(v12) as v12, SUM(annot) as annot from aggJoin8524680132817539633 group by v4;
create or replace view aggJoin3810399316989836391 as select src as v2, dst as v4, v12, annot from Graph as g2, aggView4644602948599854019 where g2.dst=aggView4644602948599854019.v4;
create or replace view aggView4611876661274631158 as select dst as v2, COUNT(*) as annot from Graph as g1 group by dst;
create or replace view aggJoin5310185265778202901 as select v2 * annot as v2, v4 * annot as v4, v12 * annot as v12 from aggJoin3810399316989836391 join aggView4611876661274631158 using(v2);
select v2,v4,SUM(v12) from aggJoin5310185265778202901 group by v2,v4;
