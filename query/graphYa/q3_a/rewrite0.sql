create or replace view g3 as select Graph.src as v4, Graph.dst as v9, v10, v14 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2, (SELECT dst, COUNT(*) AS v14 FROM Graph GROUP BY dst) AS c4 where Graph.dst = c2.src and Graph.dst = c4.dst;
create or replace view g2 as select Graph.src as v2, Graph.dst as v4, v12 from Graph, (SELECT src, COUNT(*) AS v12 FROM Graph GROUP BY src) AS c3 where Graph.src = c3.src;
create or replace view semiJoinView8798272864062481179 as select v2, v4 from g2 where (v4) in (select (v4) from g3);
create or replace view g2Aux31 as select v2 from semiJoinView8798272864062481179;
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create or replace view semiJoinView2413249409628796666 as select distinct v2 from g2Aux31 where (v2) in (select (v2) from g1);
create or replace view res as select distinct v2 from semiJoinView2413249409628796666;
/*+QUERY_TIMEOUT=86400000*/select sum(v2) from res;