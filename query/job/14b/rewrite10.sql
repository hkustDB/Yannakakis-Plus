create or replace view aggJoin7894831652428236545 as (
with aggView1282845858744103716 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView1282845858744103716 where t.kind_id=aggView1282845858744103716.v8 and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%')));
create or replace view aggJoin2685277414564815842 as (
with aggView1670630161247633309 as (select v23, MIN(v24) as v36 from aggJoin7894831652428236545 group by v23)
select movie_id as v23, info_type_id as v1, info as v13, v36 from movie_info as mi, aggView1670630161247633309 where mi.movie_id=aggView1670630161247633309.v23 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin4947213806078873541 as (
with aggView4055368334227647906 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView4055368334227647906 where mi_idx.info_type_id=aggView4055368334227647906.v3 and info>'6.0');
create or replace view aggJoin8515433173101573797 as (
with aggView6834489188751048428 as (select id as v1 from info_type as it1 where info= 'countries')
select v23, v13, v36 from aggJoin2685277414564815842 join aggView6834489188751048428 using(v1));
create or replace view aggJoin3999009399428195411 as (
with aggView2673746976373005810 as (select v23, MIN(v36) as v36 from aggJoin8515433173101573797 group by v23,v36)
select v23, v18, v36 from aggJoin4947213806078873541 join aggView2673746976373005810 using(v23));
create or replace view aggJoin757925458542249108 as (
with aggView5006971030440156762 as (select v23, MIN(v36) as v36, MIN(v18) as v35 from aggJoin3999009399428195411 group by v23,v36)
select keyword_id as v5, v36, v35 from movie_keyword as mk, aggView5006971030440156762 where mk.movie_id=aggView5006971030440156762.v23);
create or replace view aggJoin7853075759150235988 as (
with aggView3625138229115803954 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title'))
select v36, v35 from aggJoin757925458542249108 join aggView3625138229115803954 using(v5));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin7853075759150235988;
