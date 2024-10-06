create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<5;
create or replace view g2 as select Graph.src as v2, Graph.dst as v4, v12 from Graph, (SELECT src, COUNT(*) AS v12 FROM Graph GROUP BY src) AS c3 where Graph.src = c3.src;
create or replace view semiJoinView8371466786651180353 as select v2, v4, v12 from g2 where (v2) in (select v2 from g1);
create or replace view g3 as select Graph.src as v4, Graph.dst as v9, v10, v14 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2, (SELECT dst, COUNT(*) AS v14 FROM Graph GROUP BY dst) AS c4 where Graph.dst = c2.src and Graph.dst = c4.dst;
create or replace view semiJoinView4128504955603294533 as select v2, v4, v12 from semiJoinView8371466786651180353 where (v4) in (select v4 from g3);
create or replace view semiEnum2965412599304284681 as select v14, v10, v9, v2, v12, v4 from semiJoinView4128504955603294533 join g3 using(v4);
create or replace view semiEnum6304443870540448603 as select v2, v10, v9, v4, v14, v8, v12, v7 from semiEnum2965412599304284681 join g1 using(v2);
select v7, v2, v4, v9, v8, v10, v12, v14 from semiEnum6304443870540448603;