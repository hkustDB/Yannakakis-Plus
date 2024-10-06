create or replace view g1 as select Graph.src as g1src, Graph.dst as g1dst, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create or replace view g1_min as select g1dst, min(v8) as g1min from g1 group by g1dst;
create or replace view g3 as select Graph.src as g3src, Graph.dst as g3dst, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create or replace view g3_max as select g3src, max(v10) as g3max from g3 group by g3src;

create or replace view g2_1 as select src as g2src, dst as g2dst, g1min from Graph g2, g1_min where g2.dst = g1_min.g1dst;
create or replace view g2_2 as select g2src, g2dst, g1min from g2_1, g3_max where g2dst = g3src and g1min < g3max;

create or replace view res1 as select g2src, g2dst, g3dst, v10 from g2_2, g3 where g2dst = g3src and g1min < v10;
create or replace view res2 as select g1src, g3dst, v8, v10 from res1, g1 where g2src = g1dst and v8 < v10;

/*+QUERY_TIMEOUT=172800000*/select sum(g1src + g3dst + v8 + v10) from res2;
