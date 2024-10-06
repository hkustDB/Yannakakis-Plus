create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create or replace view aggView3176469251695221236 as select v2, COUNT(*) as annot from g1 group by v2;
create or replace view aggJoin5960015671000238931 as select dst as v4, annot from Graph as g2, aggView3176469251695221236 where g2.src=aggView3176469251695221236.v2;
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create or replace view aggView4583450441913275524 as select v4, SUM(annot) as annot from aggJoin5960015671000238931 group by v4;
create or replace view aggJoin9018115505382820455 as select annot from g3 join aggView4583450441913275524 using(v4);
select SUM(annot) as v11 from aggJoin9018115505382820455;
