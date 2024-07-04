create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create or replace view aggView7759350285036908200 as select v4, COUNT(*) as annot from g3 group by v4;
create or replace view aggJoin8665793002072379179 as select src as v2, annot from Graph as g2, aggView7759350285036908200 where g2.dst=aggView7759350285036908200.v4;
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create or replace view aggView620132834809159721 as select v2, SUM(annot) as annot from aggJoin8665793002072379179 group by v2;
create or replace view aggJoin3803559144706054858 as select annot from g1 join aggView620132834809159721 using(v2);
/*+QUERY_TIMEOUT=86400000*/select SUM(annot) as v11 from aggJoin3803559144706054858;
