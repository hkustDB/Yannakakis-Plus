create or replace view aggView1633510576468494563 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin588709101404495093 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView1633510576468494563 where mi_idx.movie_id=aggView1633510576468494563.v14 and info>'9.0';
create or replace view aggView3825500817674396495 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin86192080787624070 as select v14, v9, v27 from aggJoin588709101404495093 join aggView3825500817674396495 using(v1);
create or replace view aggView4974505473979506504 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin86192080787624070 group by v14,v27;
create or replace view aggJoin608755804008088583 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView4974505473979506504 where mk.movie_id=aggView4974505473979506504.v14;
create or replace view aggView6734461611224873261 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8798048054060532861 as select v27, v26 from aggJoin608755804008088583 join aggView6734461611224873261 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin8798048054060532861;
