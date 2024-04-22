create or replace view aggJoin4959556918313137469 as (
with aggView30774351489540800 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView30774351489540800 where ci.person_id=aggView30774351489540800.v2);
create or replace view aggJoin3159428179323210954 as (
with aggView2124761443090953874 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView2124761443090953874 where mk.keyword_id=aggView2124761443090953874.v33);
create or replace view aggJoin3580579623353952478 as (
with aggView4643836914328771246 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView4643836914328771246 where mc.company_id=aggView4643836914328771246.v28);
create or replace view aggJoin2401800199766606980 as (
with aggView9207785886900909055 as (select v11 from aggJoin3159428179323210954 group by v11)
select v2, v11, v55 as v55 from aggJoin4959556918313137469 join aggView9207785886900909055 using(v11));
create or replace view aggJoin9168683241230066786 as (
with aggView2323394003682639874 as (select v11 from aggJoin3580579623353952478 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView2323394003682639874 where t.id=aggView2323394003682639874.v11 and episode_nr<100);
create or replace view aggJoin6355339287047979861 as (
with aggView7243825992350046715 as (select v11, MIN(v44) as v56 from aggJoin9168683241230066786 group by v11)
select v2, v55 as v55, v56 from aggJoin2401800199766606980 join aggView7243825992350046715 using(v11));
create or replace view aggJoin6016818805032064660 as (
with aggView7099783216514980601 as (select id as v2 from name as n)
select v55, v56 from aggJoin6355339287047979861 join aggView7099783216514980601 using(v2));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin6016818805032064660;
