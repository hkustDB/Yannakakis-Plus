create or replace view aggView8090581008761963400 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin6866109215756120785 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView8090581008761963400 where mk.movie_id=aggView8090581008761963400.v14;
create or replace view aggView8287442936257860034 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin352933709262386778 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView8287442936257860034 where mi_idx.info_type_id=aggView8287442936257860034.v1 and info>'2.0';
create or replace view aggView7141177612461647662 as select v14, MIN(v9) as v26 from aggJoin352933709262386778 group by v14;
create or replace view aggJoin4858508660684653952 as select v3, v27 as v27, v26 from aggJoin6866109215756120785 join aggView7141177612461647662 using(v14);
create or replace view aggView6916860392280408558 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7294346345407009236 as select v27, v26 from aggJoin4858508660684653952 join aggView6916860392280408558 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin7294346345407009236;
