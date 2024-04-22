create or replace view aggJoin1071270735295298441 as (
with aggView3323559434306506589 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView3323559434306506589 where t.kind_id=aggView3323559434306506589.v21 and production_year>2000);
create or replace view aggJoin3766023505048816924 as (
with aggView8326054729574432063 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView8326054729574432063 where mi.info_type_id=aggView8326054729574432063.v16 and info LIKE 'USA:% 200%' and note LIKE '%internet%');
create or replace view aggJoin4475712933022708473 as (
with aggView2120720311495635175 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView2120720311495635175 where mc.company_type_id=aggView2120720311495635175.v14);
create or replace view aggJoin682407944816751701 as (
with aggView1077873811234659684 as (select id as v18 from keyword as k where keyword IN ('nerd','loner','alienation','dignity'))
select movie_id as v36 from movie_keyword as mk, aggView1077873811234659684 where mk.keyword_id=aggView1077873811234659684.v18);
create or replace view aggJoin5757029034632481531 as (
with aggView3601651952228401467 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView3601651952228401467 where cc.status_id=aggView3601651952228401467.v5);
create or replace view aggJoin4944375472534486456 as (
with aggView6612984324001904405 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin4475712933022708473 join aggView6612984324001904405 using(v7));
create or replace view aggJoin5651345350940077865 as (
with aggView701720902537832634 as (select v36 from aggJoin5757029034632481531 group by v36)
select v36, v31, v32 from aggJoin3766023505048816924 join aggView701720902537832634 using(v36));
create or replace view aggJoin649258113842782478 as (
with aggView856845376638308822 as (select v36 from aggJoin5651345350940077865 group by v36)
select v36, v37, v40, v48 as v48 from aggJoin1071270735295298441 join aggView856845376638308822 using(v36));
create or replace view aggJoin4234995066755608628 as (
with aggView6996690058819492891 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin649258113842782478 group by v36,v48)
select v36, v48, v49 from aggJoin4944375472534486456 join aggView6996690058819492891 using(v36));
create or replace view aggJoin3398005234349486460 as (
with aggView823625455792882937 as (select v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin4234995066755608628 group by v36,v48,v49)
select v48, v49 from aggJoin682407944816751701 join aggView823625455792882937 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin3398005234349486460;
