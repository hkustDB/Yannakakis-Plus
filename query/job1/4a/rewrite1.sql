create or replace view aggView4750936230633746440 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin3404355824777530000 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView4750936230633746440 where mi_idx.info_type_id=aggView4750936230633746440.v1 and info>'5.0';
create or replace view aggView690362067398326839 as select v14, MIN(v9) as v26 from aggJoin3404355824777530000 group by v14;
create or replace view aggJoin7594244815044876800 as select id as v14, title as v15, v26 from title as t, aggView690362067398326839 where t.id=aggView690362067398326839.v14 and production_year>2005;
create or replace view aggView1520082960264153082 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin7594244815044876800 group by v14;
create or replace view aggJoin5219968503325209297 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView1520082960264153082 where mk.movie_id=aggView1520082960264153082.v14;
create or replace view aggView7505324070128258428 as select v3, MIN(v26) as v26, MIN(v27) as v27 from aggJoin5219968503325209297 group by v3;
create or replace view aggJoin8935847939511751822 as select v26, v27 from keyword as k, aggView7505324070128258428 where k.id=aggView7505324070128258428.v3 and keyword LIKE '%sequel%';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin8935847939511751822;
