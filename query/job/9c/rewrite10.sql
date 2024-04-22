create or replace view aggView452692353495454536 as select id as v18, title as v47 from title as t;
create or replace view aggView2284298189396195302 as select name as v10, id as v9 from char_name as chn;
create or replace view aggView702755384684131246 as select person_id as v35, name as v3 from aka_name as an group by person_id,name;
create or replace view aggView316412397949895285 as select name as v36, id as v35 from name as n where name LIKE '%An%' and gender= 'f';
create or replace view aggJoin1563604919053171027 as (
with aggView2430705801402747467 as (select v9, MIN(v10) as v59 from aggView2284298189396195302 group by v9)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView2430705801402747467 where ci.person_role_id=aggView2430705801402747467.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4231088576519157433 as (
with aggView6173786616363184633 as (select v35, MIN(v36) as v60 from aggView316412397949895285 group by v35)
select v35, v3, v60 from aggView702755384684131246 join aggView6173786616363184633 using(v35));
create or replace view aggJoin7509593590193082357 as (
with aggView1980424966122628357 as (select v35, MIN(v60) as v60, MIN(v3) as v58 from aggJoin4231088576519157433 group by v35,v60)
select v18, v20, v22, v59 as v59, v60, v58 from aggJoin1563604919053171027 join aggView1980424966122628357 using(v35));
create or replace view aggJoin4999079589924026467 as (
with aggView311124304772776120 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v59, v60, v58 from aggJoin7509593590193082357 join aggView311124304772776120 using(v22));
create or replace view aggJoin3229181818170371199 as (
with aggView4127277428418461221 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView4127277428418461221 where mc.company_id=aggView4127277428418461221.v32);
create or replace view aggJoin5622550634418825162 as (
with aggView8132676746119623249 as (select v18 from aggJoin3229181818170371199 group by v18)
select v18, v20, v59 as v59, v60 as v60, v58 as v58 from aggJoin4999079589924026467 join aggView8132676746119623249 using(v18));
create or replace view aggJoin1717488349951640270 as (
with aggView4678208881578007653 as (select v18, MIN(v59) as v59, MIN(v60) as v60, MIN(v58) as v58 from aggJoin5622550634418825162 group by v18,v58,v60,v59)
select v47, v59, v60, v58 from aggView452692353495454536 join aggView4678208881578007653 using(v18));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v47) as v61 from aggJoin1717488349951640270;
