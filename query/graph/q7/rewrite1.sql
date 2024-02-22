create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src and v10<Graph.src;
create or replace view semiJoinView596447436173072627 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select v4 from g3);
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<Graph.dst;
create or replace view semiJoinView3658283898570273011 as select v7, v2, v8 from g1 where (v2) in (select v2 from semiJoinView596447436173072627);
create or replace view semiEnum4528903754598809729 as select v8, v4, v7, v2 from semiJoinView3658283898570273011 join semiJoinView596447436173072627 using(v2);
create or replace view semiEnum911701791753244182 as select v6, v8, v4, v7, v2, v10 from semiEnum4528903754598809729 join g3 using(v4);
select sum(v7+v2+v4+v6+v8+v10) from semiEnum911701791753244182;
