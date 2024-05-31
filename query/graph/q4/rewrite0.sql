create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create or replace view g3Aux52 as select v4, v6, v10 from g3;
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create or replace view minView4230099181664992416 as select v2, min(v8) as mfL6986067907790006119 from g1 group by v2;
create or replace view joinView4327078707237884501 as select src as v2, dst as v4, mfL6986067907790006119 from Graph AS g2, minView4230099181664992416 where g2.src=minView4230099181664992416.v2;
create or replace view minView4571035049582293561 as select v4, min(mfL6986067907790006119) as mfL3011675763823433570 from joinView4327078707237884501 group by v4;
create or replace view joinView8146454751553513819 as select distinct v4, v6 from g3Aux52 join minView4571035049582293561 using(v4) where mfL3011675763823433570<v10;
create or replace view res as select distinct v4, v6 from joinView8146454751553513819;
select sum(v4+v6) from res;
