create or replace view aggJoin1735971052078434089 as (
with aggView2315270091983368577 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView2315270091983368577 where mi.info_type_id=aggView2315270091983368577.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin3245788505718759330 as (
with aggView3635525081567935094 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView3635525081567935094 where mc.company_type_id=aggView3635525081567935094.v14);
create or replace view aggJoin3271101373243101874 as (
with aggView6786423636805000399 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView6786423636805000399 where mk.keyword_id=aggView6786423636805000399.v18);
create or replace view aggJoin9211545063963774821 as (
with aggView1589792959119801777 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin3245788505718759330 join aggView1589792959119801777 using(v7));
create or replace view aggJoin928658877191186146 as (
with aggView4992394329307041712 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView4992394329307041712 where cc.status_id=aggView4992394329307041712.v5);
create or replace view aggJoin5835601520380212682 as (
with aggView5739597813545979842 as (select v36 from aggJoin928658877191186146 group by v36)
select v36, v31, v32 from aggJoin1735971052078434089 join aggView5739597813545979842 using(v36));
create or replace view aggJoin8995713814299548065 as (
with aggView434299479583039508 as (select v36 from aggJoin5835601520380212682 group by v36)
select v36 from aggJoin9211545063963774821 join aggView434299479583039508 using(v36));
create or replace view aggJoin1108294441879820432 as (
with aggView719749390318090271 as (select v36 from aggJoin8995713814299548065 group by v36)
select v36 from aggJoin3271101373243101874 join aggView719749390318090271 using(v36));
create or replace view aggJoin1820189239224484445 as (
with aggView4105066397291231848 as (select v36 from aggJoin1108294441879820432 group by v36)
select title as v37, kind_id as v21, production_year as v40 from title as t, aggView4105066397291231848 where t.id=aggView4105066397291231848.v36 and production_year>1990);
create or replace view aggView4611967676316134804 as select v37, v21 from aggJoin1820189239224484445 group by v37,v21;
create or replace view aggJoin1769435128718296678 as (
with aggView735000746164907356 as (select id as v21, kind as v48 from kind_type as kt where kind IN ('movie','tv movie','video movie','video game'))
select v37, v48 from aggView4611967676316134804 join aggView735000746164907356 using(v21));
select MIN(v48) as v48,MIN(v37) as v49 from aggJoin1769435128718296678;
