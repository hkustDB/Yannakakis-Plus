create or replace view aggView683344081787089500 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin1827788302340672581 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView683344081787089500 where mk.movie_id=aggView683344081787089500.v14;
create or replace view aggView7729221302468918854 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin276180452458450027 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView7729221302468918854 where mi_idx.info_type_id=aggView7729221302468918854.v1 and info>'9.0';
create or replace view aggView2412227951522897077 as select v14, MIN(v9) as v26 from aggJoin276180452458450027 group by v14;
create or replace view aggJoin5450328255002593646 as select v3, v27 as v27, v26 from aggJoin1827788302340672581 join aggView2412227951522897077 using(v14);
create or replace view aggView8330203195564449830 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8219496041016944816 as select v27, v26 from aggJoin5450328255002593646 join aggView8330203195564449830 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin8219496041016944816;
