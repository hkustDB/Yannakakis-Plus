create or replace view aggJoin2598310878453633411 as (
with aggView6461110982808853499 as (select id as v26, name as v47 from name as n)
select movie_id as v3, v47 from cast_info as ci, aggView6461110982808853499 where ci.person_id=aggView6461110982808853499.v26);
create or replace view aggJoin9187665071898725590 as (
with aggView4812102774375017444 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView4812102774375017444 where mc.company_id=aggView4812102774375017444.v20);
create or replace view aggJoin6183450350443434665 as (
with aggView4869830465611734847 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView4869830465611734847 where mk.keyword_id=aggView4869830465611734847.v25);
create or replace view aggJoin4884509510986562681 as (
with aggView1533526252711467161 as (select v3 from aggJoin9187665071898725590 group by v3)
select v3 from aggJoin6183450350443434665 join aggView1533526252711467161 using(v3));
create or replace view aggJoin1316758348803044413 as (
with aggView8044920422471740495 as (select v3 from aggJoin4884509510986562681 group by v3)
select id as v3 from title as t, aggView8044920422471740495 where t.id=aggView8044920422471740495.v3);
create or replace view aggJoin5756936539225050996 as (
with aggView6984451036231689645 as (select v3 from aggJoin1316758348803044413 group by v3)
select v47 as v47 from aggJoin2598310878453633411 join aggView6984451036231689645 using(v3));
select MIN(v47) as v47 from aggJoin5756936539225050996;
