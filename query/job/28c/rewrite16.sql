create or replace view aggJoin8630964956047843523 as (
with aggView4267001380040431960 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView4267001380040431960 where mc.company_id=aggView4267001380040431960.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4563987159702381559 as (
with aggView7969951950130499147 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView7969951950130499147 where t.kind_id=aggView7969951950130499147.v25 and production_year>2005);
create or replace view aggJoin4270416341241665613 as (
with aggView9114217429181422431 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView9114217429181422431 where cc.subject_id=aggView9114217429181422431.v5);
create or replace view aggJoin4667549004993299774 as (
with aggView5001292516778488961 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin8630964956047843523 join aggView5001292516778488961 using(v16));
create or replace view aggJoin1710374667587957597 as (
with aggView1815679048715823390 as (select v45, MIN(v57) as v57 from aggJoin4667549004993299774 group by v45,v57)
select movie_id as v45, info_type_id as v20, info as v40, v57 from movie_info_idx as mi_idx, aggView1815679048715823390 where mi_idx.movie_id=aggView1815679048715823390.v45 and info<'8.5');
create or replace view aggJoin1315124402833573782 as (
with aggView2962159322994870081 as (select id as v20 from info_type as it2 where info= 'rating')
select v45, v40, v57 from aggJoin1710374667587957597 join aggView2962159322994870081 using(v20));
create or replace view aggJoin1046332526394086186 as (
with aggView1094095074579636959 as (select v45, MIN(v57) as v57, MIN(v40) as v58 from aggJoin1315124402833573782 group by v45,v57)
select v45, v7, v57, v58 from aggJoin4270416341241665613 join aggView1094095074579636959 using(v45));
create or replace view aggJoin672785464926019491 as (
with aggView1739483954765775068 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45, v57, v58 from aggJoin1046332526394086186 join aggView1739483954765775068 using(v7));
create or replace view aggJoin7973431328221567124 as (
with aggView545284351029105127 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView545284351029105127 where mk.keyword_id=aggView545284351029105127.v22);
create or replace view aggJoin3959770887683443954 as (
with aggView8319434688760582105 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView8319434688760582105 where mi.info_type_id=aggView8319434688760582105.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8181033602524926255 as (
with aggView2583429712116286836 as (select v45 from aggJoin3959770887683443954 group by v45)
select v45, v46, v49 from aggJoin4563987159702381559 join aggView2583429712116286836 using(v45));
create or replace view aggJoin7245233767419313624 as (
with aggView2263651870394964454 as (select v45, MIN(v46) as v59 from aggJoin8181033602524926255 group by v45)
select v45, v57 as v57, v58 as v58, v59 from aggJoin672785464926019491 join aggView2263651870394964454 using(v45));
create or replace view aggJoin1418153226441599535 as (
with aggView1020594487063884123 as (select v45, MIN(v57) as v57, MIN(v58) as v58, MIN(v59) as v59 from aggJoin7245233767419313624 group by v45,v57,v58,v59)
select v57, v58, v59 from aggJoin7973431328221567124 join aggView1020594487063884123 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin1418153226441599535;
