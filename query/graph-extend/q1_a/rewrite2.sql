create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create or replace view aggView7301306333689816868 as select v2, COUNT(*) as annot from g1 group by v2;
create or replace view aggJoin2000640977229423635 as select dst as v4, annot from Graph as g2, aggView7301306333689816868 where g2.src=aggView7301306333689816868.v2;
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create or replace view aggView4252758982586518478 as select v4, COUNT(*) as annot from g3 group by v4;
create or replace view aggJoin5059312846930319526 as select aggJoin2000640977229423635.annot * aggView4252758982586518478.annot as annot from aggJoin2000640977229423635 join aggView4252758982586518478 using(v4);
/*+QUERY_TIMEOUT=86400000*/select SUM(annot) as v11 from aggJoin5059312846930319526;
