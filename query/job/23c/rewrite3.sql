create or replace view aggJoin3138404503175325721 as (
with aggView6813634321399591030 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView6813634321399591030 where mi.info_type_id=aggView6813634321399591030.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin4781824184491547759 as (
with aggView2290227165450171845 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView2290227165450171845 where mk.keyword_id=aggView2290227165450171845.v18);
create or replace view aggJoin628801414469972998 as (
with aggView2072303312222663516 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView2072303312222663516 where mc.company_type_id=aggView2072303312222663516.v14);
create or replace view aggJoin8926738467770317324 as (
with aggView1889271587737961546 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin628801414469972998 join aggView1889271587737961546 using(v7));
create or replace view aggJoin4179047225798797686 as (
with aggView4621485864714978461 as (select v36 from aggJoin4781824184491547759 group by v36)
select v36, v31, v32 from aggJoin3138404503175325721 join aggView4621485864714978461 using(v36));
create or replace view aggJoin5270811484020206772 as (
with aggView4107979216368085702 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView4107979216368085702 where cc.status_id=aggView4107979216368085702.v5);
create or replace view aggJoin7121273373167740636 as (
with aggView166843212873494222 as (select v36 from aggJoin4179047225798797686 group by v36)
select id as v36, title as v37, kind_id as v21, production_year as v40 from title as t, aggView166843212873494222 where t.id=aggView166843212873494222.v36 and production_year>1990);
create or replace view aggJoin738506781671344404 as (
with aggView6297580669576906260 as (select v36 from aggJoin5270811484020206772 group by v36)
select v36 from aggJoin8926738467770317324 join aggView6297580669576906260 using(v36));
create or replace view aggJoin7790828922132963840 as (
with aggView4197058161879259747 as (select v36 from aggJoin738506781671344404 group by v36)
select v37, v21, v40 from aggJoin7121273373167740636 join aggView4197058161879259747 using(v36));
create or replace view aggView8606200769481515984 as select v37, v21 from aggJoin7790828922132963840 group by v37,v21;
create or replace view aggJoin3284876912322998523 as (
with aggView6608709120934649155 as (select v21, MIN(v37) as v49 from aggView8606200769481515984 group by v21)
select kind as v22, v49 from kind_type as kt, aggView6608709120934649155 where kt.id=aggView6608709120934649155.v21 and kind IN ('movie','tv movie','video movie','video game'));
select MIN(v22) as v48,MIN(v49) as v49 from aggJoin3284876912322998523;
