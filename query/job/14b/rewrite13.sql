create or replace view aggJoin249457124478002958 as (
with aggView8437268293277831975 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView8437268293277831975 where t.kind_id=aggView8437268293277831975.v8 and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%')));
create or replace view aggJoin382944134523120920 as (
with aggView3722430341296908281 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView3722430341296908281 where mi_idx.info_type_id=aggView3722430341296908281.v3 and info>'6.0');
create or replace view aggJoin5236021706485263489 as (
with aggView7666793426691519145 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView7666793426691519145 where mi.info_type_id=aggView7666793426691519145.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin7991355284018408416 as (
with aggView5286821651104839165 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title'))
select movie_id as v23 from movie_keyword as mk, aggView5286821651104839165 where mk.keyword_id=aggView5286821651104839165.v5);
create or replace view aggJoin2049413439054559628 as (
with aggView8351060507706013904 as (select v23 from aggJoin5236021706485263489 group by v23)
select v23, v24, v27 from aggJoin249457124478002958 join aggView8351060507706013904 using(v23));
create or replace view aggJoin1491870529280349490 as (
with aggView6305043510435188263 as (select v23, MIN(v24) as v36 from aggJoin2049413439054559628 group by v23)
select v23, v18, v36 from aggJoin382944134523120920 join aggView6305043510435188263 using(v23));
create or replace view aggJoin8225094971745458773 as (
with aggView5107806631181806471 as (select v23, MIN(v36) as v36, MIN(v18) as v35 from aggJoin1491870529280349490 group by v23,v36)
select v36, v35 from aggJoin7991355284018408416 join aggView5107806631181806471 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin8225094971745458773;
