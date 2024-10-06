create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create or replace view g2 as select Graph.src as v2, Graph.dst as v4, v12 from Graph, (SELECT src, COUNT(*) AS v12 FROM Graph GROUP BY src) AS c3 where Graph.src = c3.src;
create or replace view aggView4743162493683758847 as select v2, COUNT(*) as annot from g1 group by v2;
create or replace view aggJoin4542444878411930196 as select v4, annot from g2 join aggView4743162493683758847 using(v2);
create or replace view g3 as select Graph.src as v4, Graph.dst as v9, v10, v14 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2, (SELECT dst, COUNT(*) AS v14 FROM Graph GROUP BY dst) AS c4 where Graph.dst = c2.src and Graph.dst = c4.dst;
create or replace view aggView5459960029595792617 as select v4, SUM(annot) as annot from aggJoin4542444878411930196 group by v4;
create or replace view aggJoin3593273221663519992 as select annot from g3 join aggView5459960029595792617 using(v4);
select SUM(annot) as v15 from aggJoin3593273221663519992;
