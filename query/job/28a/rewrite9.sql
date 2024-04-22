create or replace view aggJoin899880710995696604 as (
with aggView656377696454459388 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView656377696454459388 where mc.company_id=aggView656377696454459388.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin6881827939230014353 as (
with aggView6375708839434789102 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView6375708839434789102 where mk.keyword_id=aggView6375708839434789102.v22);
create or replace view aggJoin745977099240625454 as (
with aggView888317051610755191 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView888317051610755191 where mi.info_type_id=aggView888317051610755191.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin5986298481318647358 as (
with aggView413109481213368592 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView413109481213368592 where cc.status_id=aggView413109481213368592.v7);
create or replace view aggJoin3829706822965439540 as (
with aggView4036018586897247429 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin5986298481318647358 join aggView4036018586897247429 using(v5));
create or replace view aggJoin6053396904575159376 as (
with aggView6609941742198456322 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin899880710995696604 join aggView6609941742198456322 using(v16));
create or replace view aggJoin2570156742945446925 as (
with aggView6999446910284496935 as (select v45, MIN(v57) as v57 from aggJoin6053396904575159376 group by v45,v57)
select v45, v35, v57 from aggJoin745977099240625454 join aggView6999446910284496935 using(v45));
create or replace view aggJoin3346758911137752609 as (
with aggView9001836229194839698 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView9001836229194839698 where mi_idx.info_type_id=aggView9001836229194839698.v20 and info<'8.5');
create or replace view aggJoin4961772822652253873 as (
with aggView5254021343486597739 as (select v45, MIN(v40) as v58 from aggJoin3346758911137752609 group by v45)
select v45, v58 from aggJoin3829706822965439540 join aggView5254021343486597739 using(v45));
create or replace view aggJoin7542549922365806045 as (
with aggView2747732765605183686 as (select v45, MIN(v58) as v58 from aggJoin4961772822652253873 group by v45,v58)
select id as v45, title as v46, kind_id as v25, production_year as v49, v58 from title as t, aggView2747732765605183686 where t.id=aggView2747732765605183686.v45 and production_year>2000);
create or replace view aggJoin3999668793886870203 as (
with aggView8234727265048119130 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select v45, v46, v49, v58 from aggJoin7542549922365806045 join aggView8234727265048119130 using(v25));
create or replace view aggJoin3833612378170845494 as (
with aggView6586375940269478306 as (select v45, MIN(v58) as v58, MIN(v46) as v59 from aggJoin3999668793886870203 group by v45,v58)
select v45, v35, v57 as v57, v58, v59 from aggJoin2570156742945446925 join aggView6586375940269478306 using(v45));
create or replace view aggJoin2508637342612869990 as (
with aggView808663989518226873 as (select v45, MIN(v57) as v57, MIN(v58) as v58, MIN(v59) as v59 from aggJoin3833612378170845494 group by v45,v58,v59,v57)
select v57, v58, v59 from aggJoin6881827939230014353 join aggView808663989518226873 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin2508637342612869990;
