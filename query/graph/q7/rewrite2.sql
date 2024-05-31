create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src and v10<Graph.src;
create or replace view semiJoinView112899738287173823 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select v4 from g3);
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<Graph.dst;
create or replace view semiJoinView2754954379143667275 as select v2, v4 from semiJoinView112899738287173823 where (v2) in (select v2 from g1);
create or replace view semiEnum8367020246460216599 as select v7, v2, v8, v4 from semiJoinView2754954379143667275 join g1 using(v2);
create or replace view semiEnum1907985575202500357 as select v7, v6, v2, v10, v8, v4 from semiEnum8367020246460216599 join g3 using(v4);
select sum(v7+v2+v4+v6+v8+v10) from semiEnum1907985575202500357;
