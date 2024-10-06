create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<2;
create or replace view semiJoinView4494821536451561544 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select v2 from g1);
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create or replace view semiJoinView9206771152396330360 as select v2, v4 from semiJoinView4494821536451561544 where (v4) in (select v4 from g3);
create or replace view semiEnum2217740493938547102 as select v2, v6, v10, v4 from semiJoinView9206771152396330360 join g3 using(v4);
create or replace view semiEnum1624226747543115950 as select v2, v7, v6, v10, v8, v4 from semiEnum2217740493938547102 join g1 using(v2);
select v7, v2, v4, v6, v8, v10 from semiEnum1624226747543115950;
