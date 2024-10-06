create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8, v10 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.src = c1.src and Graph.src = c2.src and v8<2;
create or replace view semiJoinView3266585226609643414 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select v2 from g1);
create or replace view semiJoinView2936695666174308445 as select distinct src as v4, dst as v6 from Graph AS g3 where (src) in (select v4 from semiJoinView3266585226609643414);
create or replace view semiEnum3902545727306770709 as select distinct v6, v2 from semiJoinView2936695666174308445 join semiJoinView3266585226609643414 using(v4);
create or replace view semiEnum2178227791311825947 as select v8, v7, v6, v10 from semiEnum3902545727306770709 join g1 using(v2);
create or replace view res as select distinct v7, v6, v8, v10 from semiEnum2178227791311825947;
/*+QUERY_TIMEOUT=86400000*/select sum(v7+v6+v8+v10) from res;