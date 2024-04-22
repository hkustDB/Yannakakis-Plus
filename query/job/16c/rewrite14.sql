create or replace view aggJoin8730349187277497121 as (
with aggView6034590294971243518 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select id as v2, v55 from name as n, aggView6034590294971243518 where n.id=aggView6034590294971243518.v2);
create or replace view aggJoin1647709097170207206 as (
with aggView7899513997914764700 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView7899513997914764700 where mk.keyword_id=aggView7899513997914764700.v33);
create or replace view aggJoin5752778891363194853 as (
with aggView8896269945362486940 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView8896269945362486940 where mc.company_id=aggView8896269945362486940.v28);
create or replace view aggJoin7351371439838790695 as (
with aggView8369356005291147589 as (select v11 from aggJoin5752778891363194853 group by v11)
select person_id as v2, movie_id as v11 from cast_info as ci, aggView8369356005291147589 where ci.movie_id=aggView8369356005291147589.v11);
create or replace view aggJoin5918658899345761315 as (
with aggView2885453100163922841 as (select v11 from aggJoin1647709097170207206 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView2885453100163922841 where t.id=aggView2885453100163922841.v11 and episode_nr<100);
create or replace view aggJoin6627481872834206383 as (
with aggView8872547840583186159 as (select v11, MIN(v44) as v56 from aggJoin5918658899345761315 group by v11)
select v2, v56 from aggJoin7351371439838790695 join aggView8872547840583186159 using(v11));
create or replace view aggJoin4542452132168246238 as (
with aggView8632516257883617587 as (select v2, MIN(v55) as v55 from aggJoin8730349187277497121 group by v2,v55)
select v56 as v56, v55 from aggJoin6627481872834206383 join aggView8632516257883617587 using(v2));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin4542452132168246238;
