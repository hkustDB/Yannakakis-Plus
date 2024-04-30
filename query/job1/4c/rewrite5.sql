create or replace view aggView7895791586149441606 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin8953996484987599481 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView7895791586149441606 where mi_idx.movie_id=aggView7895791586149441606.v14 and info>'2.0';
create or replace view aggView6918787347722283477 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin6071154654053159536 as select v14, v9, v27 from aggJoin8953996484987599481 join aggView6918787347722283477 using(v1);
create or replace view aggView2442861228091569056 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin6071154654053159536 group by v14;
create or replace view aggJoin8218092097828588551 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView2442861228091569056 where mk.movie_id=aggView2442861228091569056.v14;
create or replace view aggView8119756140829553167 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4015382430281313990 as select v27, v26 from aggJoin8218092097828588551 join aggView8119756140829553167 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin4015382430281313990;
