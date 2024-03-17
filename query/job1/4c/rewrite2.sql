create or replace view aggView8368917924033001337 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin568059905349524324 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView8368917924033001337 where mk.movie_id=aggView8368917924033001337.v14;
create or replace view aggView3722072825859529069 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1259500509567524801 as select v14, v27 from aggJoin568059905349524324 join aggView3722072825859529069 using(v3);
create or replace view aggView4377342700124344445 as select v14, MIN(v27) as v27 from aggJoin1259500509567524801 group by v14;
create or replace view aggJoin6048948454115800165 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView4377342700124344445 where mi_idx.movie_id=aggView4377342700124344445.v14 and info>'2.0';
create or replace view aggView3046819357475882092 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin8063238179844243739 as select v9, v27 from aggJoin6048948454115800165 join aggView3046819357475882092 using(v1);
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin8063238179844243739;
