create or replace view aggView7822706720760390704 as select dst as v2, SUM(src) as v12, COUNT(*) as annot, src as v1 from Graph as g1 group by dst,src;
create or replace view aggJoin4924967446029623400 as select src as v2, dst as v4, v12, v1, annot from Graph as g2, aggView7822706720760390704 where g2.src=aggView7822706720760390704.v2;
create or replace view aggView873426689199758485 as select src as v6, SUM(dst) as v11, COUNT(*) as annot, dst as v8 from Graph as g4 group by src,dst;
create or replace view aggJoin6295388244347901405 as select src as v4, dst as v6, v11, v8, annot from Graph as g3, aggView873426689199758485 where g3.dst=aggView873426689199758485.v6;
create or replace view aggView2586140376726733059 as select v4, SUM(v11) as v11, SUM(v6 * annot) as v10, SUM(annot) as annot, v8 from aggJoin6295388244347901405 group by v4,v8;
create or replace view aggJoin2105647718477222459 as select v2, v12*aggView2586140376726733059.annot as v12, v1, aggJoin4924967446029623400.annot * aggView2586140376726733059.annot as annot, v11 * aggJoin4924967446029623400.annot as v11, v10 * aggJoin4924967446029623400.annot as v10, v8 from aggJoin4924967446029623400 join aggView2586140376726733059 using(v4) where v1 < v8;
select v2,v4,annot as v9,v10,v11/annot as v11,v12/annot as v12 from aggJoin2105647718477222459;
