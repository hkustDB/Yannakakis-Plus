create or replace view aggJoin7728730985457578942 as (
with aggView5671213857909904952 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView5671213857909904952 where mk.keyword_id=aggView5671213857909904952.v33);
create or replace view aggJoin6702969715816287023 as (
with aggView368394886956940100 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView368394886956940100 where mc.company_id=aggView368394886956940100.v28);
create or replace view aggJoin2673419340600846369 as (
with aggView2422848413169416170 as (select v11 from aggJoin7728730985457578942 group by v11)
select v11 from aggJoin6702969715816287023 join aggView2422848413169416170 using(v11));
create or replace view aggJoin7055102905373123944 as (
with aggView3234360526659182300 as (select v11 from aggJoin2673419340600846369 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView3234360526659182300 where t.id=aggView3234360526659182300.v11 and episode_nr>=50 and episode_nr<100);
create or replace view aggJoin7541095590582885173 as (
with aggView2100304204003336975 as (select v11, MIN(v44) as v56 from aggJoin7055102905373123944 group by v11)
select person_id as v2, v56 from cast_info as ci, aggView2100304204003336975 where ci.movie_id=aggView2100304204003336975.v11);
create or replace view aggJoin8298926361721341328 as (
with aggView2632483183226765603 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView2632483183226765603 where an.person_id=aggView2632483183226765603.v2);
create or replace view aggJoin6895515582094958293 as (
with aggView3803598023263069891 as (select v2, MIN(v3) as v55 from aggJoin8298926361721341328 group by v2)
select v56 as v56, v55 from aggJoin7541095590582885173 join aggView3803598023263069891 using(v2));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin6895515582094958293;
