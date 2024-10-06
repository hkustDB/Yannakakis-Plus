create temp table g1 as select Graph.src as v7, Graph.dst as v2, v8, v10 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.src = c1.src and Graph.src = c2.src and v8<2;
create temp table semiUp182570954004939769 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select v2 from g1);
create temp table semiUp8006052037483660004 as select src as v4, dst as v6 from Graph AS g3 where (src) in (select v4 from semiUp182570954004939769);
create temp table semiDown6503609840766288698 as select v2, v4 from semiUp182570954004939769 where (v4) in (select v4 from semiUp8006052037483660004);
create temp table semiDown6193408868514243131 as select v7, v2, v8, v10 from g1 where (v2) in (select v2 from semiDown6503609840766288698);
create temp table joinView2062808661565948239 as select v4, v7, v8, v10 from semiDown6503609840766288698 join semiDown6193408868514243131 using(v2) GROUP BY v4, v7, v8, v10;
select v7, v6, v8, v10 from semiUp8006052037483660004 join joinView2062808661565948239 using(v4) GROUP BY v7, v8, v10, v6;
