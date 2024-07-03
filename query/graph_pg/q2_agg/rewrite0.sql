create or replace view bag6230 as select g6.src as v10, g6.dst as v12, g5.src as v8 from Graph as g6, Graph as g5, Graph as g4 where g6.src=g5.dst and g5.src=g4.dst and g4.src=g6.dst;
create or replace view aggView1441735665807012645 as select v12, COUNT(*) as annot from bag6230 group by v12;
create or replace view aggJoin2685640964298154515 as select src as v2, annot from Graph as g7, aggView1441735665807012645 where g7.dst=aggView1441735665807012645.v12;
create or replace view bag6231 as select g2.src as v2, g3.src as v4, g3.dst as v6 from Graph as g3, Graph as g2, Graph as g1 where g3.src=g2.dst and g2.src=g1.dst and g1.src=g3.dst;
create or replace view aggView8225286618782513103 as select v2, COUNT(*) as annot from bag6231 group by v2;
create or replace view aggJoin7433171757339572228 as select aggJoin2685640964298154515.annot * aggView8225286618782513103.annot as annot from aggJoin2685640964298154515 join aggView8225286618782513103 using(v2);
select SUM(annot) as v15 from aggJoin7433171757339572228;
