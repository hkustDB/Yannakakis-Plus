
drop view if exists g3 CASCADE;
drop view if exists g3_0 CASCADE;
drop view if exists semiJoinView4302997546626505758 CASCADE;
drop view if exists g1 CASCADE;
drop view if exists g2_0 CASCADE;
drop view if exists res CASCADE;
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create or replace view g3_0 as select v4 from g3 GROUP BY v4;
create or replace view semiJoinView4302997546626505758 as select src as v2, dst as v4 from Graph AS g2, g3_0 where dst = v4;
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create or replace view g2_0 as select v2 from semiJoinView4302997546626505758 GROUP BY v2;
create or replace view res as select distinct v7 from g1 join g2_0 using(v2);
/*+QUERY_TIMEOUT=86400000*/select sum(v7) from res;