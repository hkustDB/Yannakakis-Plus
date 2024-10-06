create or replace view semiJoinView420983068320263120 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select src from Graph AS g3);
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8, v10 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.src = c1.src and Graph.src = c2.src and v8<2;
create or replace view semiJoinView4369941658551504607 as select distinct v7, v2, v8, v10 from g1 where (v2) in (select v2 from semiJoinView420983068320263120);
create or replace view semiEnum6057749373435454747 as select distinct v8, v7, v4, v10 from semiJoinView4369941658551504607 join semiJoinView420983068320263120 using(v2);
create or replace view semiEnum8282586516506778556 as select v8, v7, dst as v6, v10 from semiEnum6057749373435454747, Graph as g3 where g3.src=semiEnum6057749373435454747.v4;
create or replace view res as select distinct v7, v6, v8, v10 from semiEnum8282586516506778556;
/*+QUERY_TIMEOUT=86400000*/select sum(v7+v6+v8+v10) from res;
