create temp table g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<2;
create temp table semiUp7968898408258766548 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select v2 from g1);
create temp table g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create temp table semiUp557100842360884650 as select v4, v6, v10 from g3 where (v4) in (select v4 from semiUp7968898408258766548);
create temp table semiDown4672609865056656772 as select v2, v4 from semiUp7968898408258766548 where (v4) in (select v4 from semiUp557100842360884650);
create temp table semiDown1208267837435733246 as select v7, v2, v8 from g1 where (v2) in (select v2 from semiDown4672609865056656772);
create temp table joinView4339827031584106972 as select v2, v4, v7, v8 from semiDown4672609865056656772 join semiDown1208267837435733246 using(v2);
create temp table joinView2878980370724946182 as select v4, v6, v10, v2, v7, v8 from semiUp557100842360884650 join joinView4339827031584106972 using(v4);
select v7, v2, v4, v6, v8, v10 from joinView2878980370724946182;
