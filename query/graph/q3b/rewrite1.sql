create or replace view g3 as select Graph.src as v4, Graph.dst as v9, v10, v14 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2, (SELECT dst, COUNT(*) AS v14 FROM Graph GROUP BY dst) AS c4 where Graph.dst = c2.src and Graph.dst = c4.dst;
create or replace view g2 as select Graph.src as v2, Graph.dst as v4, v12 from Graph, (SELECT src, COUNT(*) AS v12 FROM Graph GROUP BY src) AS c3 where Graph.src = c3.src;
create or replace view aggView3686241131398444367 as select v4, COUNT(*) as annot from g3 group by v4;
create or replace view aggJoin6799957062400947751 as select v2, annot from g2 join aggView3686241131398444367 using(v4);
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create or replace view aggView6865232210977177601 as select v2, SUM(annot) as annot from aggJoin6799957062400947751 group by v2;
create or replace view aggJoin7489023653915949958 as select annot from g1 join aggView6865232210977177601 using(v2);
select SUM(annot) as v15 from aggJoin7489023653915949958;
