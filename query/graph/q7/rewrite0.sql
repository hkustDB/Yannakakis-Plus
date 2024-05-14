create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src and v10<Graph.src;
create or replace view semiJoinView914723926835382282 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select (v4) from g3);
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<Graph.dst;
create or replace view semiJoinView7427663282224900031 as select v7, v2, v8 from g1 where (v2) in (select (v2) from semiJoinView914723926835382282);
create or replace view semiEnum4510279466163969869 as select v4, v8, v7, v2 from semiJoinView7427663282224900031 join semiJoinView914723926835382282 using(v2);
create or replace view semiEnum6245865409982678183 as select v4, v8, v2, v6, v7, v10 from semiEnum4510279466163969869 join g3 using(v4);
select v7, v2, v4, v6, v8, v10 from semiEnum6245865409982678183;
