create or replace view aggJoin8267508279941094374 as (
with aggView5892453699711728305 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select movie_id as v40, company_id as v13, company_type_id as v20, note as v31 from movie_companies as mc, aggView5892453699711728305 where mc.movie_id=aggView5892453699711728305.v40 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin7103944324646926386 as (
with aggView5957109472882205402 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView5957109472882205402 where mi.info_type_id=aggView5957109472882205402.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggView3578986352379993934 as select v40, v35 from aggJoin7103944324646926386 group by v40,v35;
create or replace view aggJoin4980691167199269052 as (
with aggView38677230523848072 as (select id as v13 from company_name as cn where name= 'YouTube' and country_code= '[us]')
select v40, v20, v31 from aggJoin8267508279941094374 join aggView38677230523848072 using(v13));
create or replace view aggJoin4438714854835527419 as (
with aggView1188238860697058818 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin4980691167199269052 join aggView1188238860697058818 using(v20));
create or replace view aggJoin7778843797359525406 as (
with aggView5997654105448411205 as (select v40 from aggJoin4438714854835527419 group by v40)
select movie_id as v40, keyword_id as v24 from movie_keyword as mk, aggView5997654105448411205 where mk.movie_id=aggView5997654105448411205.v40);
create or replace view aggJoin4135005502535147865 as (
with aggView2164497084038105675 as (select id as v24 from keyword as k)
select v40 from aggJoin7778843797359525406 join aggView2164497084038105675 using(v24));
create or replace view aggJoin7309346814514805525 as (
with aggView3425229245074471801 as (select v40 from aggJoin4135005502535147865 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView3425229245074471801 where t.id=aggView3425229245074471801.v40 and production_year<=2010 and production_year>=2005);
create or replace view aggView5762945423492527038 as select v40, v41 from aggJoin7309346814514805525 group by v40,v41;
create or replace view aggJoin7949923122527386676 as (
with aggView5363900646164293486 as (select v40, MIN(v41) as v53 from aggView5762945423492527038 group by v40)
select v35, v53 from aggView3578986352379993934 join aggView5363900646164293486 using(v40));
select MIN(v35) as v52,MIN(v53) as v53 from aggJoin7949923122527386676;
