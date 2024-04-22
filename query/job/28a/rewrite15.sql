create or replace view aggJoin2714778902496246586 as (
with aggView3279234205499954715 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView3279234205499954715 where mc.company_id=aggView3279234205499954715.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin3699404655471095427 as (
with aggView2017206453644011441 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView2017206453644011441 where mk.keyword_id=aggView2017206453644011441.v22);
create or replace view aggJoin2216142591272269208 as (
with aggView7749688083462942678 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView7749688083462942678 where mi.info_type_id=aggView7749688083462942678.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8625851947612415482 as (
with aggView1538231285541188134 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView1538231285541188134 where cc.status_id=aggView1538231285541188134.v7);
create or replace view aggJoin8739567502998529377 as (
with aggView5942065969646526482 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin8625851947612415482 join aggView5942065969646526482 using(v5));
create or replace view aggJoin5624448258715291870 as (
with aggView4039458140806419046 as (select v45 from aggJoin8739567502998529377 group by v45)
select v45 from aggJoin3699404655471095427 join aggView4039458140806419046 using(v45));
create or replace view aggJoin1183530595656992162 as (
with aggView8393398001978367769 as (select v45 from aggJoin2216142591272269208 group by v45)
select movie_id as v45, info_type_id as v20, info as v40 from movie_info_idx as mi_idx, aggView8393398001978367769 where mi_idx.movie_id=aggView8393398001978367769.v45 and info<'8.5');
create or replace view aggJoin8928000948271112357 as (
with aggView7295446891148510890 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin2714778902496246586 join aggView7295446891148510890 using(v16));
create or replace view aggJoin8652024689629559561 as (
with aggView4396945601542620151 as (select v45, MIN(v57) as v57 from aggJoin8928000948271112357 group by v45,v57)
select v45, v57 from aggJoin5624448258715291870 join aggView4396945601542620151 using(v45));
create or replace view aggJoin694260681978839089 as (
with aggView6489479725375763068 as (select id as v20 from info_type as it2 where info= 'rating')
select v45, v40 from aggJoin1183530595656992162 join aggView6489479725375763068 using(v20));
create or replace view aggJoin2770004591425751089 as (
with aggView6322374740007176929 as (select v45, MIN(v40) as v58 from aggJoin694260681978839089 group by v45)
select id as v45, title as v46, kind_id as v25, production_year as v49, v58 from title as t, aggView6322374740007176929 where t.id=aggView6322374740007176929.v45 and production_year>2000);
create or replace view aggJoin2795275019106023679 as (
with aggView4496868004536338768 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select v45, v46, v49, v58 from aggJoin2770004591425751089 join aggView4496868004536338768 using(v25));
create or replace view aggJoin6100029440848628989 as (
with aggView1820619638409498904 as (select v45, MIN(v58) as v58, MIN(v46) as v59 from aggJoin2795275019106023679 group by v45,v58)
select v57 as v57, v58, v59 from aggJoin8652024689629559561 join aggView1820619638409498904 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin6100029440848628989;
