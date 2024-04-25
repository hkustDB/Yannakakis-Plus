create or replace view aggJoin1840541878144747705 as (
with aggView6629451174873642554 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView6629451174873642554 where mc.company_id=aggView6629451174873642554.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin981695431233903085 as (
with aggView4565883199254953609 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView4565883199254953609 where t.kind_id=aggView4565883199254953609.v25 and production_year>2005);
create or replace view aggJoin4843579951813062264 as (
with aggView3566394699312998538 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView3566394699312998538 where cc.subject_id=aggView3566394699312998538.v5);
create or replace view aggJoin1003494341170593476 as (
with aggView4843599567799961773 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView4843599567799961773 where mi_idx.info_type_id=aggView4843599567799961773.v20 and info<'8.5');
create or replace view aggJoin7843595215007045342 as (
with aggView7659989836058155683 as (select v45, MIN(v40) as v58 from aggJoin1003494341170593476 group by v45)
select v45, v46, v49, v58 from aggJoin981695431233903085 join aggView7659989836058155683 using(v45));
create or replace view aggJoin20112602986741928 as (
with aggView6512018094750141952 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin1840541878144747705 join aggView6512018094750141952 using(v16));
create or replace view aggJoin8852094068804766687 as (
with aggView2152613443338235437 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin4843579951813062264 join aggView2152613443338235437 using(v7));
create or replace view aggJoin8450948084242632296 as (
with aggView8238650512036263646 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView8238650512036263646 where mi.info_type_id=aggView8238650512036263646.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin2189668379397733968 as (
with aggView5890017754022380159 as (select v45 from aggJoin8450948084242632296 group by v45)
select v45 from aggJoin8852094068804766687 join aggView5890017754022380159 using(v45));
create or replace view aggJoin5469234301272316501 as (
with aggView2403223458887657834 as (select v45 from aggJoin2189668379397733968 group by v45)
select v45, v31, v57 as v57 from aggJoin20112602986741928 join aggView2403223458887657834 using(v45));
create or replace view aggJoin2265212140115764683 as (
with aggView5214880973388342926 as (select v45, MIN(v57) as v57 from aggJoin5469234301272316501 group by v45)
select v45, v46, v49, v58 as v58, v57 from aggJoin7843595215007045342 join aggView5214880973388342926 using(v45));
create or replace view aggJoin840149884795387285 as (
with aggView8905384350480324986 as (select v45, MIN(v58) as v58, MIN(v57) as v57, MIN(v46) as v59 from aggJoin2265212140115764683 group by v45)
select keyword_id as v22, v58, v57, v59 from movie_keyword as mk, aggView8905384350480324986 where mk.movie_id=aggView8905384350480324986.v45);
create or replace view aggJoin8301398728355875086 as (
with aggView8735863216146351979 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v58, v57, v59 from aggJoin840149884795387285 join aggView8735863216146351979 using(v22));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin8301398728355875086;
