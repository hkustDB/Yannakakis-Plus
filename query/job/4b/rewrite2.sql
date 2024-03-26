create or replace view aggView4197095147207878197 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin6373524651373053336 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView4197095147207878197 where mi_idx.movie_id=aggView4197095147207878197.v14 and info>'9.0';
create or replace view aggView8579566261189217148 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3583141489638521022 as select movie_id as v14 from movie_keyword as mk, aggView8579566261189217148 where mk.keyword_id=aggView8579566261189217148.v3;
create or replace view aggView7675249882746570409 as select v14 from aggJoin3583141489638521022 group by v14;
create or replace view aggJoin6890082946430217900 as select v1, v9, v27 as v27 from aggJoin6373524651373053336 join aggView7675249882746570409 using(v14);
create or replace view aggView2750024550661298751 as select v1, MIN(v27) as v27, MIN(v9) as v26 from aggJoin6890082946430217900 group by v1;
create or replace view aggJoin8393350548616483817 as select v27, v26 from info_type as it, aggView2750024550661298751 where it.id=aggView2750024550661298751.v1 and info= 'rating';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin8393350548616483817;
