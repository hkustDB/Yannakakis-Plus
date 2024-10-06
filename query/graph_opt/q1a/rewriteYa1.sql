
DROP VIEW IF EXISTS g1 CASCADE;
DROP VIEW IF EXISTS semiUp7968898408258766548 CASCADE;
DROP VIEW IF EXISTS g3 CASCADE;
DROP VIEW IF EXISTS semiUp557100842360884650 CASCADE;
DROP VIEW IF EXISTS semiDown4672609865056656772 CASCADE;
DROP VIEW IF EXISTS semiDown1208267837435733246 CASCADE;
DROP VIEW IF EXISTS joinView4339827031584106972 CASCADE;
DROP VIEW IF EXISTS joinView2878980370724946182 CASCADE;
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src and v8<2;
create or replace view semiUp7968898408258766548 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select v2 from g1);
create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create or replace view semiUp557100842360884650 as select v4, v6, v10 from g3 where (v4) in (select v4 from semiUp7968898408258766548);
create or replace view semiDown4672609865056656772 as select v2, v4 from semiUp7968898408258766548 where (v4) in (select v4 from semiUp557100842360884650);
create or replace view semiDown1208267837435733246 as select v7, v2, v8 from g1 where (v2) in (select v2 from semiDown4672609865056656772);
create or replace view joinView4339827031584106972 as select v2, v4, v7, v8 from semiDown4672609865056656772 join semiDown1208267837435733246 using(v2);
create or replace view joinView2878980370724946182 as select v4, v6, v10, v2, v7, v8 from semiUp557100842360884650 join joinView4339827031584106972 using(v4);
/*+QUERY_TIMEOUT=86400000*/select sum(v4+v6+v10+v2+v7+v8) from joinView2878980370724946182;
