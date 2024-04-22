create or replace view aggJoin122196369597826111 as (
with aggView2229187327305268915 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView2229187327305268915 where mc.company_id=aggView2229187327305268915.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin2608046014397386520 as (
with aggView1529103693027296256 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView1529103693027296256 where mk.keyword_id=aggView1529103693027296256.v22);
create or replace view aggJoin6217276796480752779 as (
with aggView1869992479410796688 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView1869992479410796688 where mi.info_type_id=aggView1869992479410796688.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin3379792456839557201 as (
with aggView7647744169326536800 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView7647744169326536800 where cc.status_id=aggView7647744169326536800.v7);
create or replace view aggJoin8939196253869436146 as (
with aggView6797265490105890756 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin3379792456839557201 join aggView6797265490105890756 using(v5));
create or replace view aggJoin3610158229159840571 as (
with aggView7642485042836836108 as (select v45 from aggJoin6217276796480752779 group by v45)
select movie_id as v45, info_type_id as v20, info as v40 from movie_info_idx as mi_idx, aggView7642485042836836108 where mi_idx.movie_id=aggView7642485042836836108.v45 and info<'8.5');
create or replace view aggJoin6940948442644624147 as (
with aggView2061670300397379964 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin122196369597826111 join aggView2061670300397379964 using(v16));
create or replace view aggJoin233448071892235457 as (
with aggView663717848540729130 as (select v45, MIN(v57) as v57 from aggJoin6940948442644624147 group by v45,v57)
select v45, v57 from aggJoin2608046014397386520 join aggView663717848540729130 using(v45));
create or replace view aggJoin584103402586246593 as (
with aggView6590863038789810332 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView6590863038789810332 where t.kind_id=aggView6590863038789810332.v25 and production_year>2000);
create or replace view aggJoin5178542063631036161 as (
with aggView9165043167616759263 as (select v45, MIN(v46) as v59 from aggJoin584103402586246593 group by v45)
select v45, v59 from aggJoin8939196253869436146 join aggView9165043167616759263 using(v45));
create or replace view aggJoin1143407788726520046 as (
with aggView2620984407938734026 as (select v45, MIN(v59) as v59 from aggJoin5178542063631036161 group by v45,v59)
select v45, v20, v40, v59 from aggJoin3610158229159840571 join aggView2620984407938734026 using(v45));
create or replace view aggJoin5955614627350852998 as (
with aggView2028859122460549001 as (select id as v20 from info_type as it2 where info= 'rating')
select v45, v40, v59 from aggJoin1143407788726520046 join aggView2028859122460549001 using(v20));
create or replace view aggJoin3135682966743527810 as (
with aggView540850447876709989 as (select v45, MIN(v59) as v59, MIN(v40) as v58 from aggJoin5955614627350852998 group by v45,v59)
select v57 as v57, v59, v58 from aggJoin233448071892235457 join aggView540850447876709989 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin3135682966743527810;
