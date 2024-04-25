create or replace view aggView2697415950472148636 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin2319189601676660201 as (
with aggView2277819391789436393 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView2277819391789436393 where t.kind_id=aggView2277819391789436393.v25 and production_year>2005);
create or replace view aggView1076652102496096748 as select v45, v46 from aggJoin2319189601676660201 group by v45,v46;
create or replace view aggJoin8846850189891372550 as (
with aggView1884657333307781825 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView1884657333307781825 where mi_idx.info_type_id=aggView1884657333307781825.v20 and info<'8.5');
create or replace view aggView720361144845517255 as select v45, v40 from aggJoin8846850189891372550 group by v45,v40;
create or replace view aggJoin984878408428407315 as (
with aggView7953137904077908219 as (select v45, MIN(v46) as v59 from aggView1076652102496096748 group by v45)
select v45, v40, v59 from aggView720361144845517255 join aggView7953137904077908219 using(v45));
create or replace view aggJoin538146860977905721 as (
with aggView4607884110561096439 as (select v45, MIN(v59) as v59, MIN(v40) as v58 from aggJoin984878408428407315 group by v45)
select movie_id as v45, company_id as v9, company_type_id as v16, note as v31, v59, v58 from movie_companies as mc, aggView4607884110561096439 where mc.movie_id=aggView4607884110561096439.v45 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin8309318348689834280 as (
with aggView454399022614196825 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView454399022614196825 where cc.subject_id=aggView454399022614196825.v5);
create or replace view aggJoin1678431082181866559 as (
with aggView3038857613779808898 as (select id as v16 from company_type as ct)
select v45, v9, v31, v59, v58 from aggJoin538146860977905721 join aggView3038857613779808898 using(v16));
create or replace view aggJoin3698272630324634613 as (
with aggView3881775933846206070 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin8309318348689834280 join aggView3881775933846206070 using(v7));
create or replace view aggJoin8921467620504336568 as (
with aggView952164074832589908 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView952164074832589908 where mk.keyword_id=aggView952164074832589908.v22);
create or replace view aggJoin6926940799259901078 as (
with aggView3843798334244362797 as (select v45 from aggJoin8921467620504336568 group by v45)
select v45 from aggJoin3698272630324634613 join aggView3843798334244362797 using(v45));
create or replace view aggJoin5044708619368740666 as (
with aggView2497349950817134863 as (select v45 from aggJoin6926940799259901078 group by v45)
select v45, v9, v31, v59 as v59, v58 as v58 from aggJoin1678431082181866559 join aggView2497349950817134863 using(v45));
create or replace view aggJoin2516607147538306776 as (
with aggView3197519784175472120 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView3197519784175472120 where mi.info_type_id=aggView3197519784175472120.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin794982469991807533 as (
with aggView748572682607975161 as (select v45 from aggJoin2516607147538306776 group by v45)
select v9, v31, v59 as v59, v58 as v58 from aggJoin5044708619368740666 join aggView748572682607975161 using(v45));
create or replace view aggJoin2873735111839126005 as (
with aggView5499690339729309405 as (select v9, MIN(v59) as v59, MIN(v58) as v58 from aggJoin794982469991807533 group by v9)
select v10, v59, v58 from aggView2697415950472148636 join aggView5499690339729309405 using(v9));
select MIN(v10) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin2873735111839126005;
