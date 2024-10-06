create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<5;
create or replace view g2 as select Graph.src as v2, Graph.dst as v4, v12 from Graph, (SELECT src, COUNT(*) AS v12 FROM Graph GROUP BY src) AS c3 where Graph.src = c3.src;
create or replace view g3 as select Graph.src as v4, Graph.dst as v9, v10, v14 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2, (SELECT dst, COUNT(*) AS v14 FROM Graph GROUP BY dst) AS c4 where Graph.dst = c2.src and Graph.dst = c4.dst;
create or replace view semiJoinView3490531790439417022 as select v4, v9, v10, v14 from g3 where (v4) in (select v4 from semiJoinView444966550382830414);
create or replace view semiEnum8393246556235228363 as select v2, v14, v10, v9, v12, v4 from semiJoinView3490531790439417022 join semiJoinView444966550382830414 using(v4);
create or replace view semiEnum30757211987272603 as select v2, v10, v9, v4, v14, v8, v12, v7 from semiEnum8393246556235228363 join g1 using(v2);
select v7, v2, v4, v9, v8, v10, v12, v14 from semiEnum30757211987272603;
