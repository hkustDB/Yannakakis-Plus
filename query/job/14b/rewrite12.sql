create or replace view aggJoin4016671074744341521 as (
with aggView8441731937800590717 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView8441731937800590717 where t.kind_id=aggView8441731937800590717.v8 and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%')));
create or replace view aggJoin7633578878697221677 as (
with aggView5761957454188809571 as (select v23, MIN(v24) as v36 from aggJoin4016671074744341521 group by v23)
select movie_id as v23, info_type_id as v3, info as v18, v36 from movie_info_idx as mi_idx, aggView5761957454188809571 where mi_idx.movie_id=aggView5761957454188809571.v23 and info>'6.0');
create or replace view aggJoin4314140059903550161 as (
with aggView908692338452982985 as (select id as v3 from info_type as it2 where info= 'rating')
select v23, v18, v36 from aggJoin7633578878697221677 join aggView908692338452982985 using(v3));
create or replace view aggJoin2469836976870408718 as (
with aggView8215807427241730472 as (select v23, MIN(v36) as v36, MIN(v18) as v35 from aggJoin4314140059903550161 group by v23,v36)
select movie_id as v23, info_type_id as v1, info as v13, v36, v35 from movie_info as mi, aggView8215807427241730472 where mi.movie_id=aggView8215807427241730472.v23 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin3677112229048012522 as (
with aggView8580945808796059875 as (select id as v1 from info_type as it1 where info= 'countries')
select v23, v13, v36, v35 from aggJoin2469836976870408718 join aggView8580945808796059875 using(v1));
create or replace view aggJoin287853058280292966 as (
with aggView5676342053611569890 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title'))
select movie_id as v23 from movie_keyword as mk, aggView5676342053611569890 where mk.keyword_id=aggView5676342053611569890.v5);
create or replace view aggJoin7260479930754291823 as (
with aggView6730601606426028141 as (select v23, MIN(v36) as v36, MIN(v35) as v35 from aggJoin3677112229048012522 group by v23,v36,v35)
select v36, v35 from aggJoin287853058280292966 join aggView6730601606426028141 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin7260479930754291823;
