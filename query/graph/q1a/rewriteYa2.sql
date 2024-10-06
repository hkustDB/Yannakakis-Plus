create temp table g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create temp table semiUp2888979063151549454 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select v4 from g3);
create temp table g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<2;
create temp table semiUp1506119180625094627 as select v2, v4 from semiUp2888979063151549454 where (v2) in (select v2 from g1);
create temp table semiDown5140684049181280502 as select v7, v2, v8 from g1 where (v2) in (select v2 from semiUp1506119180625094627);
create temp table semiDown8951418430866816276 as select v4, v6, v10 from g3 where (v4) in (select v4 from semiUp1506119180625094627);
create temp table joinView5357089972968636351 as select v2, v4, v7, v8 from semiUp1506119180625094627 join semiDown5140684049181280502 using(v2);
create temp table joinView2228893725264769449 as select v2, v4, v7, v8, v6, v10 from joinView5357089972968636351 join semiDown8951418430866816276 using(v4);
select v7, v2, v4, v6, v8, v10 from joinView2228893725264769449;
