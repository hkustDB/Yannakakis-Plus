create or replace view aggJoin3590310787840188714 as (
with aggView7821165478272298359 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView7821165478272298359 where mc.company_id=aggView7821165478272298359.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin2971707619705187151 as (
with aggView1837349789120493962 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView1837349789120493962 where t.kind_id=aggView1837349789120493962.v25 and production_year>2005);
create or replace view aggJoin6308793348477519434 as (
with aggView8825124773135041167 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView8825124773135041167 where cc.subject_id=aggView8825124773135041167.v5);
create or replace view aggJoin7682833734566187447 as (
with aggView1156919427193361460 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin3590310787840188714 join aggView1156919427193361460 using(v16));
create or replace view aggJoin2229477958596064255 as (
with aggView7274415233606105641 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView7274415233606105641 where mi_idx.info_type_id=aggView7274415233606105641.v20 and info<'8.5');
create or replace view aggJoin1117878269808700994 as (
with aggView5683639664894304494 as (select v45, MIN(v40) as v58 from aggJoin2229477958596064255 group by v45)
select v45, v46, v49, v58 from aggJoin2971707619705187151 join aggView5683639664894304494 using(v45));
create or replace view aggJoin209963299214674873 as (
with aggView6107295821921314059 as (select v45, MIN(v58) as v58, MIN(v46) as v59 from aggJoin1117878269808700994 group by v45,v58)
select movie_id as v45, info_type_id as v18, info as v35, v58, v59 from movie_info as mi, aggView6107295821921314059 where mi.movie_id=aggView6107295821921314059.v45 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin9170992573946776009 as (
with aggView3129207813413614173 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin6308793348477519434 join aggView3129207813413614173 using(v7));
create or replace view aggJoin4318595272457502685 as (
with aggView3008763125726442715 as (select v45 from aggJoin9170992573946776009 group by v45)
select v45, v31, v57 as v57 from aggJoin7682833734566187447 join aggView3008763125726442715 using(v45));
create or replace view aggJoin3738655015239185922 as (
with aggView4262468896055666123 as (select v45, MIN(v57) as v57 from aggJoin4318595272457502685 group by v45,v57)
select movie_id as v45, keyword_id as v22, v57 from movie_keyword as mk, aggView4262468896055666123 where mk.movie_id=aggView4262468896055666123.v45);
create or replace view aggJoin738728067471721133 as (
with aggView7062003475544021523 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v45, v57 from aggJoin3738655015239185922 join aggView7062003475544021523 using(v22));
create or replace view aggJoin8364180413037517683 as (
with aggView1624024340433080808 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35, v58, v59 from aggJoin209963299214674873 join aggView1624024340433080808 using(v18));
create or replace view aggJoin2832859717107389143 as (
with aggView8579874477169850872 as (select v45, MIN(v58) as v58, MIN(v59) as v59 from aggJoin8364180413037517683 group by v45,v58,v59)
select v57 as v57, v58, v59 from aggJoin738728067471721133 join aggView8579874477169850872 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin2832859717107389143;
