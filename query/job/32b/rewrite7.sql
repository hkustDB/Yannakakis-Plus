create or replace view aggJoin3625173805930454389 as (
with aggView5175402275971553570 as (select id as v11, title as v39 from title as t2)
select movie_id as v13, link_type_id as v4, v39 from movie_link as ml, aggView5175402275971553570 where ml.linked_movie_id=aggView5175402275971553570.v11);
create or replace view aggJoin4447191271364282400 as (
with aggView2746487775378982474 as (select id as v13, title as v38 from title as t1)
select movie_id as v13, keyword_id as v8, v38 from movie_keyword as mk, aggView2746487775378982474 where mk.movie_id=aggView2746487775378982474.v13);
create or replace view aggJoin5921440211597968350 as (
with aggView2277018875994503012 as (select id as v4, link as v37 from link_type as lt)
select v13, v39, v37 from aggJoin3625173805930454389 join aggView2277018875994503012 using(v4));
create or replace view aggJoin7529199244193749111 as (
with aggView3297949652440763328 as (select v13, MIN(v39) as v39, MIN(v37) as v37 from aggJoin5921440211597968350 group by v13,v37,v39)
select v8, v38 as v38, v39, v37 from aggJoin4447191271364282400 join aggView3297949652440763328 using(v13));
create or replace view aggJoin2523658102699881233 as (
with aggView7237646218107223493 as (select id as v8 from keyword as k where keyword= 'character-name-in-title')
select v38, v39, v37 from aggJoin7529199244193749111 join aggView7237646218107223493 using(v8));
select MIN(v37) as v37,MIN(v38) as v38,MIN(v39) as v39 from aggJoin2523658102699881233;
