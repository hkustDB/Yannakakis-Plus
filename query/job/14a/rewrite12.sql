create or replace view aggJoin4459775667876162701 as (
with aggView3292396966140154412 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView3292396966140154412 where mi_idx.info_type_id=aggView3292396966140154412.v3 and info<'8.5');
create or replace view aggJoin8757868076905020509 as (
with aggView6770130224012022823 as (select v23, MIN(v18) as v35 from aggJoin4459775667876162701 group by v23)
select movie_id as v23, info_type_id as v1, info as v13, v35 from movie_info as mi, aggView6770130224012022823 where mi.movie_id=aggView6770130224012022823.v23 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin373963393935932223 as (
with aggView97603362856714630 as (select id as v1 from info_type as it1 where info= 'countries')
select v23, v13, v35 from aggJoin8757868076905020509 join aggView97603362856714630 using(v1));
create or replace view aggJoin496668041438744569 as (
with aggView8452418527734033247 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView8452418527734033247 where mk.keyword_id=aggView8452418527734033247.v5);
create or replace view aggJoin1200274994292016293 as (
with aggView4288250599622793542 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView4288250599622793542 where t.kind_id=aggView4288250599622793542.v8 and production_year>2010);
create or replace view aggJoin1915674172336692340 as (
with aggView2061623018108767179 as (select v23, MIN(v35) as v35 from aggJoin373963393935932223 group by v23,v35)
select v23, v24, v27, v35 from aggJoin1200274994292016293 join aggView2061623018108767179 using(v23));
create or replace view aggJoin9112952842197757381 as (
with aggView2780399630169144028 as (select v23, MIN(v35) as v35, MIN(v24) as v36 from aggJoin1915674172336692340 group by v23,v35)
select v35, v36 from aggJoin496668041438744569 join aggView2780399630169144028 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin9112952842197757381;
