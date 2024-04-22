create or replace view aggView8796687573147603251 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin4877742236949153586 as (
with aggView3560376789963095867 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView3560376789963095867 where mk.keyword_id=aggView3560376789963095867.v22);
create or replace view aggJoin5406968203322518029 as (
with aggView544923345832724557 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView544923345832724557 where mi.info_type_id=aggView544923345832724557.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin7186221980661218764 as (
with aggView6762770447943581025 as (select v45 from aggJoin4877742236949153586 group by v45)
select v45, v35 from aggJoin5406968203322518029 join aggView6762770447943581025 using(v45));
create or replace view aggJoin4277333535048695535 as (
with aggView4291781921705540259 as (select v45 from aggJoin7186221980661218764 group by v45)
select movie_id as v45, subject_id as v5, status_id as v7 from complete_cast as cc, aggView4291781921705540259 where cc.movie_id=aggView4291781921705540259.v45);
create or replace view aggJoin2810832334785770618 as (
with aggView55022735930937915 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select v45, v5 from aggJoin4277333535048695535 join aggView55022735930937915 using(v7));
create or replace view aggJoin4806052997459898447 as (
with aggView706028487155425084 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin2810832334785770618 join aggView706028487155425084 using(v5));
create or replace view aggJoin2080529032893341568 as (
with aggView9003786006289829776 as (select v45 from aggJoin4806052997459898447 group by v45)
select id as v45, title as v46, kind_id as v25, production_year as v49 from title as t, aggView9003786006289829776 where t.id=aggView9003786006289829776.v45 and production_year>2000);
create or replace view aggJoin6693971459204432406 as (
with aggView6952729622144733590 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select v45, v46, v49 from aggJoin2080529032893341568 join aggView6952729622144733590 using(v25));
create or replace view aggView1756339323549278513 as select v45, v46 from aggJoin6693971459204432406 group by v45,v46;
create or replace view aggJoin6166615131539854075 as (
with aggView9079620886926203395 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView9079620886926203395 where mi_idx.info_type_id=aggView9079620886926203395.v20 and info<'8.5');
create or replace view aggView8246716096994789210 as select v40, v45 from aggJoin6166615131539854075 group by v40,v45;
create or replace view aggJoin1490236840208301657 as (
with aggView4561205237587196871 as (select v9, MIN(v10) as v57 from aggView8796687573147603251 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView4561205237587196871 where mc.company_id=aggView4561205237587196871.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4691019746896535273 as (
with aggView7833388075285206914 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin1490236840208301657 join aggView7833388075285206914 using(v16));
create or replace view aggJoin7585345854199152180 as (
with aggView7753224334515291774 as (select v45, MIN(v57) as v57 from aggJoin4691019746896535273 group by v45,v57)
select v45, v46, v57 from aggView1756339323549278513 join aggView7753224334515291774 using(v45));
create or replace view aggJoin4289962086044492273 as (
with aggView2197452057279586107 as (select v45, MIN(v57) as v57, MIN(v46) as v59 from aggJoin7585345854199152180 group by v45,v57)
select v40, v57, v59 from aggView8246716096994789210 join aggView2197452057279586107 using(v45));
select MIN(v57) as v57,MIN(v40) as v58,MIN(v59) as v59 from aggJoin4289962086044492273;
