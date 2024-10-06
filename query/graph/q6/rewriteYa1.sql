create temp table semiUp222521465741379424 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select src from Graph AS g3);
create temp table g1 as select Graph.src as v7, Graph.dst as v2, v8, v10 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.src = c1.src and Graph.src = c2.src and v8<2;
create temp table semiUp4450686509153869630 as select v7, v2, v8, v10 from g1 where (v2) in (select v2 from semiUp222521465741379424);
create temp table semiDown1291695291256245155 as select v2, v4 from semiUp222521465741379424 where (v2) in (select v2 from semiUp4450686509153869630);
create temp table semiDown5846759927778601783 as select src as v4, dst as v6 from Graph AS g3 where (src) in (select v4 from semiDown1291695291256245155);
create temp table joinView4573660932544422068 as select v2, v6 from semiDown1291695291256245155 join semiDown5846759927778601783 using(v4) GROUP BY v2, v6;
select v7, v6, v8, v10 from semiUp4450686509153869630 join joinView4573660932544422068 using(v2) GROUP BY v7, v8, v10, v6;