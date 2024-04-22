create or replace view aggJoin7665835492405034654 as (
with aggView5830530952690517095 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView5830530952690517095 where t.kind_id=aggView5830530952690517095.v8 and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%')));
create or replace view aggJoin3474338814139591792 as (
with aggView4507719761016991656 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView4507719761016991656 where mi_idx.info_type_id=aggView4507719761016991656.v3 and info>'6.0');
create or replace view aggJoin725811514986113060 as (
with aggView1670516550745280448 as (select v23, MIN(v18) as v35 from aggJoin3474338814139591792 group by v23)
select movie_id as v23, info_type_id as v1, info as v13, v35 from movie_info as mi, aggView1670516550745280448 where mi.movie_id=aggView1670516550745280448.v23 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin5449791654529266658 as (
with aggView4768886068524932071 as (select id as v1 from info_type as it1 where info= 'countries')
select v23, v13, v35 from aggJoin725811514986113060 join aggView4768886068524932071 using(v1));
create or replace view aggJoin5453867718273229820 as (
with aggView6067228841816054136 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title'))
select movie_id as v23 from movie_keyword as mk, aggView6067228841816054136 where mk.keyword_id=aggView6067228841816054136.v5);
create or replace view aggJoin5268205146581191804 as (
with aggView983224409896192371 as (select v23, MIN(v35) as v35 from aggJoin5449791654529266658 group by v23,v35)
select v23, v24, v27, v35 from aggJoin7665835492405034654 join aggView983224409896192371 using(v23));
create or replace view aggJoin3618979829901406023 as (
with aggView9204574698788847163 as (select v23, MIN(v35) as v35, MIN(v24) as v36 from aggJoin5268205146581191804 group by v23,v35)
select v35, v36 from aggJoin5453867718273229820 join aggView9204574698788847163 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin3618979829901406023;
