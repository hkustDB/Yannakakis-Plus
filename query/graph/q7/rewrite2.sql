create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src and v10<Graph.src;
create or replace view semiJoinView7928355482072363501 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select v4 from g3);
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<Graph.dst;
create or replace view semiJoinView8383089454333479164 as select v2, v4 from semiJoinView7928355482072363501 where (v2) in (select v2 from g1);
create or replace view semiEnum3739131303018108776 as select v2, v8, v7, v4 from semiJoinView8383089454333479164 join g1 using(v2);
create or replace view semiEnum2723539631879919038 as select v2, v8, v10, v6, v4, v7 from semiEnum3739131303018108776 join g3 using(v4);
select sum(v7+v2+v4+v6+v8+v10) from semiEnum2723539631879919038;
