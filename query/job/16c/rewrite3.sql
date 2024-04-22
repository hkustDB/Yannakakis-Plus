create or replace view aggView1712180446029689526 as select person_id as v2, name as v3 from aka_name as an group by person_id,name;
create or replace view aggJoin817722784332677826 as (
with aggView7987397696284449480 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView7987397696284449480 where mk.keyword_id=aggView7987397696284449480.v33);
create or replace view aggJoin1327001381497272002 as (
with aggView1790832309422249836 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView1790832309422249836 where mc.company_id=aggView1790832309422249836.v28);
create or replace view aggJoin3324804595483905024 as (
with aggView4375721461291897764 as (select v11 from aggJoin817722784332677826 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView4375721461291897764 where t.id=aggView4375721461291897764.v11 and episode_nr<100);
create or replace view aggJoin6811448625146109802 as (
with aggView3661997523437780338 as (select v11 from aggJoin1327001381497272002 group by v11)
select v11, v44, v52 from aggJoin3324804595483905024 join aggView3661997523437780338 using(v11));
create or replace view aggView1508716628937668642 as select v44, v11 from aggJoin6811448625146109802 group by v44,v11;
create or replace view aggJoin355989701829908126 as (
with aggView4502434594425690369 as (select v2, MIN(v3) as v55 from aggView1712180446029689526 group by v2)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView4502434594425690369 where ci.person_id=aggView4502434594425690369.v2);
create or replace view aggJoin6755468881642485488 as (
with aggView9177389520255561111 as (select id as v2 from name as n)
select v11, v55 from aggJoin355989701829908126 join aggView9177389520255561111 using(v2));
create or replace view aggJoin3629895712617407043 as (
with aggView4508406430125840613 as (select v11, MIN(v55) as v55 from aggJoin6755468881642485488 group by v11,v55)
select v44, v55 from aggView1508716628937668642 join aggView4508406430125840613 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin3629895712617407043;
