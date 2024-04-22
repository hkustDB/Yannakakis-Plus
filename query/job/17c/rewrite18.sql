create or replace view aggJoin3976101583063028203 as (
with aggView4748888451226247249 as (select id as v26, name as v47 from name as n where name LIKE 'X%')
select movie_id as v3, v47 from cast_info as ci, aggView4748888451226247249 where ci.person_id=aggView4748888451226247249.v26);
create or replace view aggJoin2930272129387173106 as (
with aggView2036517925029435875 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView2036517925029435875 where mk.keyword_id=aggView2036517925029435875.v25);
create or replace view aggJoin2735329538031795512 as (
with aggView2256833060858055183 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView2256833060858055183 where mc.company_id=aggView2256833060858055183.v20);
create or replace view aggJoin1465411326742547528 as (
with aggView7614796021830882167 as (select v3 from aggJoin2735329538031795512 group by v3)
select v3, v47 as v47 from aggJoin3976101583063028203 join aggView7614796021830882167 using(v3));
create or replace view aggJoin8311054045133162472 as (
with aggView5547778491508941696 as (select v3 from aggJoin2930272129387173106 group by v3)
select id as v3 from title as t, aggView5547778491508941696 where t.id=aggView5547778491508941696.v3);
create or replace view aggJoin6330974725933416932 as (
with aggView7057898727000187999 as (select v3 from aggJoin8311054045133162472 group by v3)
select v47 as v47 from aggJoin1465411326742547528 join aggView7057898727000187999 using(v3));
select MIN(v47) as v47 from aggJoin6330974725933416932;
