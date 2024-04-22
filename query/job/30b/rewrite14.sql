create or replace view aggJoin5862423282041534806 as (
with aggView2994082891717312728 as (select id as v36, name as v59 from name as n where gender= 'm')
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView2994082891717312728 where ci.person_id=aggView2994082891717312728.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8099657760235070989 as (
with aggView1556928731873227511 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView1556928731873227511 where cc.status_id=aggView1556928731873227511.v7);
create or replace view aggJoin3855862507397741241 as (
with aggView4874994084968796128 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView4874994084968796128 where mk.keyword_id=aggView4874994084968796128.v20);
create or replace view aggJoin7884960458350153470 as (
with aggView3033009676921552710 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView3033009676921552710 where mi.info_type_id=aggView3033009676921552710.v16 and info IN ('Horror','Thriller'));
create or replace view aggJoin725650211023249480 as (
with aggView5727822224016066715 as (select v45, MIN(v26) as v57 from aggJoin7884960458350153470 group by v45)
select movie_id as v45, info_type_id as v18, info as v31, v57 from movie_info_idx as mi_idx, aggView5727822224016066715 where mi_idx.movie_id=aggView5727822224016066715.v45);
create or replace view aggJoin1792952818839012963 as (
with aggView5627982502883385908 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v45 from aggJoin8099657760235070989 join aggView5627982502883385908 using(v5));
create or replace view aggJoin5753203435052761864 as (
with aggView6765070166264759746 as (select v45 from aggJoin1792952818839012963 group by v45)
select v45 from aggJoin3855862507397741241 join aggView6765070166264759746 using(v45));
create or replace view aggJoin7883140067630254598 as (
with aggView7529165725417815055 as (select id as v18 from info_type as it2 where info= 'votes')
select v45, v31, v57 from aggJoin725650211023249480 join aggView7529165725417815055 using(v18));
create or replace view aggJoin3243015575768758622 as (
with aggView8069500958319120446 as (select v45, MIN(v57) as v57, MIN(v31) as v58 from aggJoin7883140067630254598 group by v45,v57)
select id as v45, title as v46, production_year as v49, v57, v58 from title as t, aggView8069500958319120446 where t.id=aggView8069500958319120446.v45 and ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000);
create or replace view aggJoin6725446314846424550 as (
with aggView878187964221675822 as (select v45, MIN(v57) as v57, MIN(v58) as v58, MIN(v46) as v60 from aggJoin3243015575768758622 group by v45,v58,v57)
select v45, v13, v59 as v59, v57, v58, v60 from aggJoin5862423282041534806 join aggView878187964221675822 using(v45));
create or replace view aggJoin9126543498378329772 as (
with aggView3055620949747955866 as (select v45, MIN(v59) as v59, MIN(v57) as v57, MIN(v58) as v58, MIN(v60) as v60 from aggJoin6725446314846424550 group by v45,v58,v59,v60,v57)
select v59, v57, v58, v60 from aggJoin5753203435052761864 join aggView3055620949747955866 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin9126543498378329772;
