create or replace view aggJoin1648773152634224 as (
with aggView1059958728038228564 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView1059958728038228564 where mc.company_id=aggView1059958728038228564.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin8169223790698262635 as (
with aggView7269358872694225204 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView7269358872694225204 where mk.keyword_id=aggView7269358872694225204.v22);
create or replace view aggJoin553377262995050703 as (
with aggView4638477735667115166 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView4638477735667115166 where mi.info_type_id=aggView4638477735667115166.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8279734172692747598 as (
with aggView3100125231080079087 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView3100125231080079087 where cc.status_id=aggView3100125231080079087.v7);
create or replace view aggJoin1390641943172912651 as (
with aggView2572885519640178273 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin8279734172692747598 join aggView2572885519640178273 using(v5));
create or replace view aggJoin6770866027280410865 as (
with aggView3268462912676167820 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin1648773152634224 join aggView3268462912676167820 using(v16));
create or replace view aggJoin2227281928170423122 as (
with aggView1562505002412412359 as (select v45 from aggJoin1390641943172912651 group by v45)
select v45, v31, v57 as v57 from aggJoin6770866027280410865 join aggView1562505002412412359 using(v45));
create or replace view aggJoin3856389083635969630 as (
with aggView1074464556574126713 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView1074464556574126713 where mi_idx.info_type_id=aggView1074464556574126713.v20 and info<'8.5');
create or replace view aggJoin8154819526708451811 as (
with aggView4158770245501762894 as (select v45, MIN(v40) as v58 from aggJoin3856389083635969630 group by v45)
select v45, v31, v57 as v57, v58 from aggJoin2227281928170423122 join aggView4158770245501762894 using(v45));
create or replace view aggJoin2385310660057793427 as (
with aggView885704630709749686 as (select v45, MIN(v57) as v57, MIN(v58) as v58 from aggJoin8154819526708451811 group by v45,v58,v57)
select v45, v35, v57, v58 from aggJoin553377262995050703 join aggView885704630709749686 using(v45));
create or replace view aggJoin3999845183659932706 as (
with aggView5391403913043953432 as (select v45, MIN(v57) as v57, MIN(v58) as v58 from aggJoin2385310660057793427 group by v45,v58,v57)
select v45, v57, v58 from aggJoin8169223790698262635 join aggView5391403913043953432 using(v45));
create or replace view aggJoin3399773650164457102 as (
with aggView1773717453552758517 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView1773717453552758517 where t.kind_id=aggView1773717453552758517.v25 and production_year>2000);
create or replace view aggJoin73067215910300124 as (
with aggView4440520118259346680 as (select v45, MIN(v46) as v59 from aggJoin3399773650164457102 group by v45)
select v57 as v57, v58 as v58, v59 from aggJoin3999845183659932706 join aggView4440520118259346680 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin73067215910300124;
