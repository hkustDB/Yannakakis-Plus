create or replace view aggJoin8123063419792036425 as (
with aggView4122138640487863923 as (select id as v22 from name as n where gender= 'f')
select movie_id as v31, note as v5 from cast_info as ci, aggView4122138640487863923 where ci.person_id=aggView4122138640487863923.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin2858156451289729430 as (
with aggView8693782711884516063 as (select id as v10 from info_type as it2 where info= 'rating')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView8693782711884516063 where mi_idx.info_type_id=aggView8693782711884516063.v10 and info>'8.0');
create or replace view aggJoin652354299912920568 as (
with aggView4191519348911393276 as (select v31, MIN(v20) as v44 from aggJoin2858156451289729430 group by v31)
select id as v31, title as v32, production_year as v35, v44 from title as t, aggView4191519348911393276 where t.id=aggView4191519348911393276.v31 and production_year>=2008 and production_year<=2014);
create or replace view aggJoin8503007720163712979 as (
with aggView1762916918692335959 as (select v31, MIN(v44) as v44, MIN(v32) as v45 from aggJoin652354299912920568 group by v31,v44)
select v31, v5, v44, v45 from aggJoin8123063419792036425 join aggView1762916918692335959 using(v31));
create or replace view aggJoin872371808689302467 as (
with aggView6318964848030007948 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView6318964848030007948 where mi.info_type_id=aggView6318964848030007948.v8 and info IN ('Horror','Thriller'));
create or replace view aggJoin7837729412718937129 as (
with aggView8841075237210038651 as (select v31, MIN(v15) as v43 from aggJoin872371808689302467 group by v31)
select v44 as v44, v45 as v45, v43 from aggJoin8503007720163712979 join aggView8841075237210038651 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin7837729412718937129;
