create or replace view aggJoin3528634737205737194 as (
with aggView8261085533542377086 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView8261085533542377086 where t.kind_id=aggView8261085533542377086.v8 and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%')));
create or replace view aggJoin4068062464318701137 as (
with aggView5397386165814824861 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView5397386165814824861 where mi_idx.info_type_id=aggView5397386165814824861.v3 and info>'6.0');
create or replace view aggJoin7677697186242605804 as (
with aggView611086946147693454 as (select v23, MIN(v18) as v35 from aggJoin4068062464318701137 group by v23)
select movie_id as v23, keyword_id as v5, v35 from movie_keyword as mk, aggView611086946147693454 where mk.movie_id=aggView611086946147693454.v23);
create or replace view aggJoin175706026071824113 as (
with aggView2167357215790003243 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView2167357215790003243 where mi.info_type_id=aggView2167357215790003243.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin6203030504389101681 as (
with aggView2087777649080834509 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title'))
select v23, v35 from aggJoin7677697186242605804 join aggView2087777649080834509 using(v5));
create or replace view aggJoin5863799067616913678 as (
with aggView3396047708309379850 as (select v23 from aggJoin175706026071824113 group by v23)
select v23, v24, v27 from aggJoin3528634737205737194 join aggView3396047708309379850 using(v23));
create or replace view aggJoin279377067030791003 as (
with aggView3998645141358859828 as (select v23, MIN(v24) as v36 from aggJoin5863799067616913678 group by v23)
select v35 as v35, v36 from aggJoin6203030504389101681 join aggView3998645141358859828 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin279377067030791003;
