create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create or replace view g3Aux17 as select v4, v6 from g3;
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<3;
create or replace view g1_proj as select v2 from g1 GROUP BY v2;
create or replace view semiJoinView5604146182483969244 as select dst as v4 from Graph AS g2, g1_proj where g2.src = v2 GROUP BY dst;
/*+QUERY_TIMEOUT=86400000*/select sum(v4+v6) from g3Aux17 join semiJoinView5604146182483969244 using(v4);
