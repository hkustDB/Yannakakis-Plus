create or replace view aggJoin3879053090089606974 as (
with aggView7668855774135538271 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView7668855774135538271 where mc.company_id=aggView7668855774135538271.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4302566597646533504 as (
with aggView4634002087064049409 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView4634002087064049409 where t.kind_id=aggView4634002087064049409.v25 and production_year>2005);
create or replace view aggJoin5443959950690859033 as (
with aggView1867871147451583605 as (select v45, MIN(v46) as v59 from aggJoin4302566597646533504 group by v45)
select v45, v16, v31, v57 as v57, v59 from aggJoin3879053090089606974 join aggView1867871147451583605 using(v45));
create or replace view aggJoin4691633656112566472 as (
with aggView2512796694888094910 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView2512796694888094910 where cc.subject_id=aggView2512796694888094910.v5);
create or replace view aggJoin6966220872447937009 as (
with aggView7886283839517685711 as (select id as v16 from company_type as ct)
select v45, v31, v57, v59 from aggJoin5443959950690859033 join aggView7886283839517685711 using(v16));
create or replace view aggJoin4013052362420022482 as (
with aggView829943580616975363 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView829943580616975363 where mi_idx.info_type_id=aggView829943580616975363.v20 and info<'8.5');
create or replace view aggJoin8133243114709585380 as (
with aggView5180305612174685325 as (select v45, MIN(v40) as v58 from aggJoin4013052362420022482 group by v45)
select movie_id as v45, info_type_id as v18, info as v35, v58 from movie_info as mi, aggView5180305612174685325 where mi.movie_id=aggView5180305612174685325.v45 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin4710725308457443981 as (
with aggView2403197637449222255 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin4691633656112566472 join aggView2403197637449222255 using(v7));
create or replace view aggJoin5137922563370444216 as (
with aggView2456344445520838244 as (select v45 from aggJoin4710725308457443981 group by v45)
select v45, v31, v57 as v57, v59 as v59 from aggJoin6966220872447937009 join aggView2456344445520838244 using(v45));
create or replace view aggJoin4329155933666430943 as (
with aggView8113275324009339063 as (select v45, MIN(v57) as v57, MIN(v59) as v59 from aggJoin5137922563370444216 group by v45,v57,v59)
select movie_id as v45, keyword_id as v22, v57, v59 from movie_keyword as mk, aggView8113275324009339063 where mk.movie_id=aggView8113275324009339063.v45);
create or replace view aggJoin9188168629506065048 as (
with aggView4511541383460520203 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v45, v57, v59 from aggJoin4329155933666430943 join aggView4511541383460520203 using(v22));
create or replace view aggJoin4861591259915996508 as (
with aggView5276931812309373431 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35, v58 from aggJoin8133243114709585380 join aggView5276931812309373431 using(v18));
create or replace view aggJoin1054947851778175294 as (
with aggView8094814256681095879 as (select v45, MIN(v58) as v58 from aggJoin4861591259915996508 group by v45,v58)
select v57 as v57, v59 as v59, v58 from aggJoin9188168629506065048 join aggView8094814256681095879 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin1054947851778175294;
