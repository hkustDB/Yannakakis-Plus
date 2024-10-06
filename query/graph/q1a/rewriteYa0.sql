create temp table g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create temp table semiUp5158477671496740338 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select v4 from g3);
create temp table g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<2;
create temp table semiUp7644701936707842368 as select v7, v2, v8 from g1 where (v2) in (select v2 from semiUp5158477671496740338);
create temp table semiDown7967174396486732787 as select v2, v4 from semiUp5158477671496740338 where (v2) in (select v2 from semiUp7644701936707842368);
create temp table semiDown6861813274736507022 as select v4, v6, v10 from g3 where (v4) in (select v4 from semiDown7967174396486732787);
create temp table joinView3426361677249748792 as select v2, v4, v6, v10 from semiDown7967174396486732787 join semiDown6861813274736507022 using(v4);
create temp table joinView3099151450942935383 as select v7, v2, v8, v4, v6, v10 from semiUp7644701936707842368 join joinView3426361677249748792 using(v2);
select v7, v2, v4, v6, v8, v10 from joinView3099151450942935383;
