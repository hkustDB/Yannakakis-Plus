create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src and v10<Graph.src;
create or replace view semiJoinView291445704353548595 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select v4 from g3);
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<Graph.dst;
create or replace view semiJoinView4164923448710529194 as select v2, v4 from semiJoinView291445704353548595 where (v2) in (select v2 from g1);
create or replace view semiEnum7631167449522202279 as select v8, v4, v7, v2 from semiJoinView4164923448710529194 join g1 using(v2);
create or replace view semiEnum2068921154242018519 as select v6, v8, v4, v7, v2, v10 from semiEnum7631167449522202279 join g3 using(v4);
select sum(v4+v6) FROM semiEnum2068921154242018519;
