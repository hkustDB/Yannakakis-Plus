create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create or replace view aggView8073285948594691310 as select v4, COUNT(*) as annot from g3 group by v4;
create or replace view aggJoin1974115531320092615 as select src as v2, annot from Graph as g2, aggView8073285948594691310 where g2.dst=aggView8073285948594691310.v4;
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create or replace view aggView7320408333188148779 as select v2, SUM(annot) as annot from aggJoin1974115531320092615 group by v2;
create or replace view aggJoin5733190898541071662 as select annot from g1 join aggView7320408333188148779 using(v2);
select SUM(annot) as v11 from aggJoin5733190898541071662;
