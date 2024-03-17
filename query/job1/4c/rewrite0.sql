create or replace view aggView5253650835913586625 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2634306624149764439 as select movie_id as v14 from movie_keyword as mk, aggView5253650835913586625 where mk.keyword_id=aggView5253650835913586625.v3;
create or replace view aggView7046730839108846514 as select v14 from aggJoin2634306624149764439 group by v14;
create or replace view aggJoin4865938114853238299 as select id as v14, title as v15 from title as t, aggView7046730839108846514 where t.id=aggView7046730839108846514.v14 and production_year>1990;
create or replace view aggView3751695931570635193 as select v14, MIN(v15) as v27 from aggJoin4865938114853238299 group by v14;
create or replace view aggJoin268695455587336649 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView3751695931570635193 where mi_idx.movie_id=aggView3751695931570635193.v14 and info>'2.0';
create or replace view aggView7760588773583521313 as select v1, MIN(v27) as v27, MIN(v9) as v26 from aggJoin268695455587336649 group by v1;
create or replace view aggJoin2823364585348680381 as select v27, v26 from info_type as it, aggView7760588773583521313 where it.id=aggView7760588773583521313.v1 and info= 'rating';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin2823364585348680381;
