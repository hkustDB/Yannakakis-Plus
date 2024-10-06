create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create or replace view aggView7836191533287499332 as select v2, COUNT(*) as annot from g1 group by v2;
create or replace view aggJoin4635551217355764011 as select dst as v4, annot from Graph as g2, aggView7836191533287499332 where g2.src=aggView7836191533287499332.v2;
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create or replace view aggView542469136677310648 as select v4, SUM(annot) as annot from aggJoin4635551217355764011 group by v4;
create or replace view aggJoin6998767452413032484 as select annot from g3 join aggView542469136677310648 using(v4);
select SUM(annot) as v11 from aggJoin6998767452413032484;
