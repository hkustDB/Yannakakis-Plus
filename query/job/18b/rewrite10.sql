create or replace view aggJoin7088706739310726696 as (
with aggView3276286441075022398 as (select id as v31, title as v45 from title as t where production_year>=2008 and production_year<=2014)
select movie_id as v31, info_type_id as v8, info as v15, v45 from movie_info as mi, aggView3276286441075022398 where mi.movie_id=aggView3276286441075022398.v31 and info IN ('Horror','Thriller'));
create or replace view aggJoin5918945198062224503 as (
with aggView8480789187559450389 as (select id as v22 from name as n where gender= 'f')
select movie_id as v31, note as v5 from cast_info as ci, aggView8480789187559450389 where ci.person_id=aggView8480789187559450389.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin2582493894197225967 as (
with aggView3953185639437491461 as (select id as v10 from info_type as it2 where info= 'rating')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView3953185639437491461 where mi_idx.info_type_id=aggView3953185639437491461.v10 and info>'8.0');
create or replace view aggJoin1579329080808750857 as (
with aggView3690369100815494602 as (select id as v8 from info_type as it1 where info= 'genres')
select v31, v15, v45 from aggJoin7088706739310726696 join aggView3690369100815494602 using(v8));
create or replace view aggJoin8133398887418871249 as (
with aggView585510637276514312 as (select v31, MIN(v45) as v45, MIN(v15) as v43 from aggJoin1579329080808750857 group by v31,v45)
select v31, v20, v45, v43 from aggJoin2582493894197225967 join aggView585510637276514312 using(v31));
create or replace view aggJoin3303257054501225183 as (
with aggView5277199180027646177 as (select v31, MIN(v45) as v45, MIN(v43) as v43, MIN(v20) as v44 from aggJoin8133398887418871249 group by v31,v43,v45)
select v45, v43, v44 from aggJoin5918945198062224503 join aggView5277199180027646177 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin3303257054501225183;
