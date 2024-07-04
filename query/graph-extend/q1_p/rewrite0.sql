create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create or replace view semiJoinView6626454006366795572 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select (v4) from g3);
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create or replace view semiJoinView8513299837812272599 as select v7, v2 from g1 where (v2) in (select (v2) from semiJoinView6626454006366795572);
create or replace view g1Aux6 as select v7 from semiJoinView8513299837812272599;
create or replace view res as select distinct v7 from g1Aux6;
/*+QUERY_TIMEOUT=86400000*/select sum(v7) from res;
