create or replace view semiJoinView2429319952108302475 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select (src) from Graph AS g3);
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8, v10 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.src = c1.src and Graph.src = c2.src and v8<v10;
create or replace view semiJoinView462713871794376343 as select distinct v7, v2, v8, v10 from g1 where (v2) in (select (v2) from semiJoinView2429319952108302475);
create or replace view semiEnum620695005920951383 as select distinct v7, v10, v4, v8 from semiJoinView462713871794376343 join semiJoinView2429319952108302475 using(v2);
create or replace view semiEnum3470284934654112130 as select dst as v6, v7, v10, v8 from semiEnum620695005920951383, Graph as g3 where g3.src=semiEnum620695005920951383.v4;
create or replace view res as select distinct v7, v6, v8, v10 from semiEnum3470284934654112130;
/*+QUERY_TIMEOUT=86400000*/select sum(v7 + v6 + v8 + v10) from res;
