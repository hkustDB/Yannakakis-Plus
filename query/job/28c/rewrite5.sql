create or replace view aggView4566165143928419428 as select id as v9, name as v10 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin8226876200193432411 as (
with aggView4130628955576836600 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView4130628955576836600 where t.kind_id=aggView4130628955576836600.v25 and production_year>2005);
create or replace view aggJoin7863990340943342867 as (
with aggView7972323432045845598 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView7972323432045845598 where cc.subject_id=aggView7972323432045845598.v5);
create or replace view aggJoin8544409548960467341 as (
with aggView7080264983538204038 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView7080264983538204038 where mi_idx.info_type_id=aggView7080264983538204038.v20);
create or replace view aggJoin2350319583389300738 as (
with aggView5325520752241889960 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin7863990340943342867 join aggView5325520752241889960 using(v7));
create or replace view aggJoin5109496389379999621 as (
with aggView1581050678222072453 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView1581050678222072453 where mk.keyword_id=aggView1581050678222072453.v22);
create or replace view aggJoin5644880945401874894 as (
with aggView7443423076596351750 as (select v45 from aggJoin5109496389379999621 group by v45)
select v45, v46, v49 from aggJoin8226876200193432411 join aggView7443423076596351750 using(v45));
create or replace view aggView3750873796729395572 as select v46, v45 from aggJoin5644880945401874894 group by v46,v45;
create or replace view aggJoin6752713599283320239 as (
with aggView1362330765451469976 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView1362330765451469976 where mi.info_type_id=aggView1362330765451469976.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin5749003701230617750 as (
with aggView214153770600420735 as (select v45 from aggJoin6752713599283320239 group by v45)
select v45 from aggJoin2350319583389300738 join aggView214153770600420735 using(v45));
create or replace view aggJoin331688177467087536 as (
with aggView5985359999182847422 as (select v45 from aggJoin5749003701230617750 group by v45)
select v45, v40 from aggJoin8544409548960467341 join aggView5985359999182847422 using(v45));
create or replace view aggJoin576979643688377004 as (
with aggView1965320018253701122 as (select v40, v45 from aggJoin331688177467087536 group by v40,v45)
select v45, v40 from aggView1965320018253701122 where v40<'8.5');
create or replace view aggJoin7017069765925936711 as (
with aggView3911664000027637056 as (select v45, MIN(v40) as v58 from aggJoin576979643688377004 group by v45)
select movie_id as v45, company_id as v9, company_type_id as v16, note as v31, v58 from movie_companies as mc, aggView3911664000027637056 where mc.movie_id=aggView3911664000027637056.v45 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4138882239145581670 as (
with aggView9058776160708790708 as (select v9, MIN(v10) as v57 from aggView4566165143928419428 group by v9)
select v45, v16, v31, v58 as v58, v57 from aggJoin7017069765925936711 join aggView9058776160708790708 using(v9));
create or replace view aggJoin1771978610202840456 as (
with aggView310814137040842022 as (select id as v16 from company_type as ct)
select v45, v31, v58, v57 from aggJoin4138882239145581670 join aggView310814137040842022 using(v16));
create or replace view aggJoin6677271084494437342 as (
with aggView8835937248173029500 as (select v45, MIN(v58) as v58, MIN(v57) as v57 from aggJoin1771978610202840456 group by v45,v57,v58)
select v46, v58, v57 from aggView3750873796729395572 join aggView8835937248173029500 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v46) as v59 from aggJoin6677271084494437342;
