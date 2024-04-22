create or replace view aggJoin2503371658868054651 as (
with aggView6905129423532120573 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView6905129423532120573 where mi_idx.info_type_id=aggView6905129423532120573.v3 and info<'8.5');
create or replace view aggJoin5267631375146781659 as (
with aggView5556445216679187793 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView5556445216679187793 where mi.info_type_id=aggView5556445216679187793.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin4633509632879110271 as (
with aggView4435814729424845164 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView4435814729424845164 where mk.keyword_id=aggView4435814729424845164.v5);
create or replace view aggJoin3318077468636776075 as (
with aggView8162923472059718032 as (select v23 from aggJoin5267631375146781659 group by v23)
select v23, v18 from aggJoin2503371658868054651 join aggView8162923472059718032 using(v23));
create or replace view aggJoin3416069553924929837 as (
with aggView5550171195146956673 as (select v23, MIN(v18) as v35 from aggJoin3318077468636776075 group by v23)
select v23, v35 from aggJoin4633509632879110271 join aggView5550171195146956673 using(v23));
create or replace view aggJoin7856900377344510391 as (
with aggView5914540735172821616 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView5914540735172821616 where t.kind_id=aggView5914540735172821616.v8 and production_year>2010);
create or replace view aggJoin1869044360322648636 as (
with aggView8709716611631255111 as (select v23, MIN(v24) as v36 from aggJoin7856900377344510391 group by v23)
select v35 as v35, v36 from aggJoin3416069553924929837 join aggView8709716611631255111 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin1869044360322648636;
