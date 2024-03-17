create or replace view aggView2546415658044178790 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1771947789262325460 as select movie_id as v14 from movie_keyword as mk, aggView2546415658044178790 where mk.keyword_id=aggView2546415658044178790.v3;
create or replace view aggView7468107421461069482 as select v14 from aggJoin1771947789262325460 group by v14;
create or replace view aggJoin746832614957824943 as select id as v14, title as v15 from title as t, aggView7468107421461069482 where t.id=aggView7468107421461069482.v14 and production_year>1990;
create or replace view aggView4257009824638933849 as select v14, MIN(v15) as v27 from aggJoin746832614957824943 group by v14;
create or replace view aggJoin4283271422319059779 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView4257009824638933849 where mi_idx.movie_id=aggView4257009824638933849.v14 and info>'2.0';
create or replace view aggView4837817382777099835 as select v1, MIN(v27) as v27, MIN(v9) as v26 from aggJoin4283271422319059779 group by v1;
create or replace view aggJoin8959056054808246298 as select v27, v26 from info_type as it, aggView4837817382777099835 where it.id=aggView4837817382777099835.v1 and info= 'rating';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin8959056054808246298;
