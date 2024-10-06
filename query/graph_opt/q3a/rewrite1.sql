create or replace view g3 as select Graph.src as v4, Graph.dst as v9, v10, v14 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2, (SELECT dst, COUNT(*) AS v14 FROM Graph GROUP BY dst) AS c4 where Graph.dst = c2.src and Graph.dst = c4.dst;
create or replace view g2 as select Graph.src as v2, Graph.dst as v4, v12 from Graph, (SELECT src, COUNT(*) AS v12 FROM Graph GROUP BY src) AS c3 where Graph.src = c3.src;
create or replace view semiJoinView1633274939740875415 as select v2, v4, v12 from g2 where (v4) in (select v4 from g3);
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<5;
create or replace view semiJoinView826568676661751047 as select v7, v2, v8 from g1 where (v2) in (select v2 from semiJoinView1633274939740875415);
create or replace view semiEnum8129667115573427272 as select v2, v8, v12, v7, v4 from semiJoinView826568676661751047 join semiJoinView1633274939740875415 using(v2);
create or replace view semiEnum651440724050053635 as select v10, v9, v2, v4, v14, v8, v12, v7 from semiEnum8129667115573427272 join g3 using(v4);
/*+QUERY_TIMEOUT=86400000*/select sum(v10+v9+v2+v4+v14+v8+v12+v7) from semiEnum651440724050053635;