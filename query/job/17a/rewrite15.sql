create or replace view aggJoin1767682674236494717 as (
with aggView6960742888830381916 as (select id as v26, name as v47 from name as n where name LIKE 'B%')
select movie_id as v3, v47 from cast_info as ci, aggView6960742888830381916 where ci.person_id=aggView6960742888830381916.v26);
create or replace view aggJoin3726704095211162543 as (
with aggView4686226663873855581 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView4686226663873855581 where mc.company_id=aggView4686226663873855581.v20);
create or replace view aggJoin4906271366859129426 as (
with aggView9132959870852715053 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView9132959870852715053 where mk.keyword_id=aggView9132959870852715053.v25);
create or replace view aggJoin9135327292963200395 as (
with aggView1404606234431213562 as (select id as v3 from title as t)
select v3 from aggJoin4906271366859129426 join aggView1404606234431213562 using(v3));
create or replace view aggJoin5828822871300965181 as (
with aggView3787698603943006869 as (select v3 from aggJoin9135327292963200395 group by v3)
select v3 from aggJoin3726704095211162543 join aggView3787698603943006869 using(v3));
create or replace view aggJoin7158995553213208881 as (
with aggView7818831670638765826 as (select v3 from aggJoin5828822871300965181 group by v3)
select v47 as v47 from aggJoin1767682674236494717 join aggView7818831670638765826 using(v3));
select MIN(v47) as v47 from aggJoin7158995553213208881;
