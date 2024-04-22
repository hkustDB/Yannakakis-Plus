create or replace view aggJoin3773393457684308583 as (
with aggView8076386425959052430 as (select id as v11, title as v56 from title as t where episode_nr>=50 and episode_nr<100)
select movie_id as v11, keyword_id as v33, v56 from movie_keyword as mk, aggView8076386425959052430 where mk.movie_id=aggView8076386425959052430.v11);
create or replace view aggJoin1816689718866168706 as (
with aggView1332064075910022054 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select id as v2, v55 from name as n, aggView1332064075910022054 where n.id=aggView1332064075910022054.v2);
create or replace view aggJoin4004859398610767174 as (
with aggView7455482659594985721 as (select v2, MIN(v55) as v55 from aggJoin1816689718866168706 group by v2,v55)
select movie_id as v11, v55 from cast_info as ci, aggView7455482659594985721 where ci.person_id=aggView7455482659594985721.v2);
create or replace view aggJoin5456545329186282623 as (
with aggView2017427506769546047 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select v11, v56 from aggJoin3773393457684308583 join aggView2017427506769546047 using(v33));
create or replace view aggJoin5844082823808879861 as (
with aggView1134038589789962111 as (select v11, MIN(v56) as v56 from aggJoin5456545329186282623 group by v11,v56)
select v11, v55 as v55, v56 from aggJoin4004859398610767174 join aggView1134038589789962111 using(v11));
create or replace view aggJoin5245650769660965225 as (
with aggView1278807037322287160 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView1278807037322287160 where mc.company_id=aggView1278807037322287160.v28);
create or replace view aggJoin2326757246502452130 as (
with aggView2519518791738231574 as (select v11 from aggJoin5245650769660965225 group by v11)
select v55 as v55, v56 as v56 from aggJoin5844082823808879861 join aggView2519518791738231574 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin2326757246502452130;
