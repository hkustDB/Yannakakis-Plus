create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create or replace view g3Aux5 as select v4, v6, v10 from g3;
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create or replace view minView7939951884320969217 as select v2, v8 as mfL5593724007092184160 from g1;
create or replace view joinView4459027404603699962 as select src as v2, dst as v4, mfL5593724007092184160 from Graph AS g2, minView7939951884320969217 where g2.src=minView7939951884320969217.v2;
create or replace view minView1865589155647858021 as select v4, mfL5593724007092184160 as mfL310100507585590691 from joinView4459027404603699962;
create or replace view joinView8023837617662965704 as select distinct v4, v6 from g3Aux5 join minView1865589155647858021 using(v4) where mfL310100507585590691<v10;
select distinct v4, v6 from joinView8023837617662965704;
