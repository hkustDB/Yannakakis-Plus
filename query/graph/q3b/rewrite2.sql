create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create or replace view g2 as select Graph.src as v2, Graph.dst as v4, v12 from Graph, (SELECT src, COUNT(*) AS v12 FROM Graph GROUP BY src) AS c3 where Graph.src = c3.src;
create or replace view aggView202582411057130804 as select v2, COUNT(*) as annot from g1 group by v2;
create or replace view aggJoin5834044577006455477 as select v4, annot from g2 join aggView202582411057130804 using(v2);
create or replace view g3 as select Graph.src as v4, Graph.dst as v9, v10, v14 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2, (SELECT dst, COUNT(*) AS v14 FROM Graph GROUP BY dst) AS c4 where Graph.dst = c2.src and Graph.dst = c4.dst;
create or replace view aggView6244039302136438316 as select v4, COUNT(*) as annot from g3 group by v4;
create or replace view aggJoin9078477608880041552 as select aggJoin5834044577006455477.annot * aggView6244039302136438316.annot as annot from aggJoin5834044577006455477 join aggView6244039302136438316 using(v4);
select SUM(annot) as v15 from aggJoin9078477608880041552;
