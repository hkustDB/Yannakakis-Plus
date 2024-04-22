create or replace view aggJoin5491363730870641466 as (
with aggView4806538639529762348 as (select id as v9, name as v59 from char_name as chn)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView4806538639529762348 where ci.person_role_id=aggView4806538639529762348.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin5124364296390231477 as (
with aggView5920996274439084430 as (select id as v18, title as v61 from title as t)
select movie_id as v18, company_id as v32, v61 from movie_companies as mc, aggView5920996274439084430 where mc.movie_id=aggView5920996274439084430.v18);
create or replace view aggJoin5783114227045042798 as (
with aggView2143808800096308966 as (select id as v35, name as v60 from name as n where name LIKE '%An%' and gender= 'f')
select person_id as v35, name as v3, v60 from aka_name as an, aggView2143808800096308966 where an.person_id=aggView2143808800096308966.v35);
create or replace view aggJoin5326246054091008277 as (
with aggView8887539708593976016 as (select v35, MIN(v60) as v60, MIN(v3) as v58 from aggJoin5783114227045042798 group by v35,v60)
select v18, v20, v22, v59 as v59, v60, v58 from aggJoin5491363730870641466 join aggView8887539708593976016 using(v35));
create or replace view aggJoin337616871514888527 as (
with aggView442363088835221471 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v59, v60, v58 from aggJoin5326246054091008277 join aggView442363088835221471 using(v22));
create or replace view aggJoin4330626205925365262 as (
with aggView7158947565247111288 as (select id as v32 from company_name as cn where country_code= '[us]')
select v18, v61 from aggJoin5124364296390231477 join aggView7158947565247111288 using(v32));
create or replace view aggJoin8115181167667405647 as (
with aggView4269511049625707726 as (select v18, MIN(v59) as v59, MIN(v60) as v60, MIN(v58) as v58 from aggJoin337616871514888527 group by v18,v58,v60,v59)
select v61 as v61, v59, v60, v58 from aggJoin4330626205925365262 join aggView4269511049625707726 using(v18));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin8115181167667405647;
