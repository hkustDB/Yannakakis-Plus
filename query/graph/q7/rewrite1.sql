create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<Graph.dst;
create or replace view semiJoinView815477579845290674 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select (v2) from g1);
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src and v10<Graph.src;
create or replace view semiJoinView459254354513667194 as select v4, v6, v10 from g3 where (v4) in (select (v4) from semiJoinView815477579845290674);
create or replace view semiEnum4999050885740679738 as select v4, v6, v2, v10 from semiJoinView459254354513667194 join semiJoinView815477579845290674 using(v4);
create or replace view semiEnum3113945873908567730 as select v4, v8, v6, v7, v2, v10 from semiEnum4999050885740679738 join g1 using(v2);
select v7, v2, v4, v6, v8, v10 from semiEnum3113945873908567730;
