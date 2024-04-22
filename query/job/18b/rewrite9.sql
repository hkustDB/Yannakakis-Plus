create or replace view aggJoin6205207610260976752 as (
with aggView7380076564862030306 as (select id as v31, title as v45 from title as t where production_year>=2008 and production_year<=2014)
select movie_id as v31, info_type_id as v10, info as v20, v45 from movie_info_idx as mi_idx, aggView7380076564862030306 where mi_idx.movie_id=aggView7380076564862030306.v31 and info>'8.0');
create or replace view aggJoin3733696905103254845 as (
with aggView3354806795880200983 as (select id as v22 from name as n where gender= 'f')
select movie_id as v31, note as v5 from cast_info as ci, aggView3354806795880200983 where ci.person_id=aggView3354806795880200983.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8290373977892978157 as (
with aggView8852424294831498403 as (select id as v10 from info_type as it2 where info= 'rating')
select v31, v20, v45 from aggJoin6205207610260976752 join aggView8852424294831498403 using(v10));
create or replace view aggJoin6466954453510255421 as (
with aggView5416707200627729014 as (select v31, MIN(v45) as v45, MIN(v20) as v44 from aggJoin8290373977892978157 group by v31,v45)
select movie_id as v31, info_type_id as v8, info as v15, v45, v44 from movie_info as mi, aggView5416707200627729014 where mi.movie_id=aggView5416707200627729014.v31 and info IN ('Horror','Thriller'));
create or replace view aggJoin6132768379216091495 as (
with aggView4019837777349335683 as (select id as v8 from info_type as it1 where info= 'genres')
select v31, v15, v45, v44 from aggJoin6466954453510255421 join aggView4019837777349335683 using(v8));
create or replace view aggJoin8979097737591412555 as (
with aggView2469929620649927272 as (select v31, MIN(v45) as v45, MIN(v44) as v44, MIN(v15) as v43 from aggJoin6132768379216091495 group by v31,v44,v45)
select v45, v44, v43 from aggJoin3733696905103254845 join aggView2469929620649927272 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin8979097737591412555;
