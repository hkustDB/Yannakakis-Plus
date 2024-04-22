create or replace view aggJoin3351915758946221118 as (
with aggView4096983037209559935 as (select id as v26, name as v47 from name as n where name LIKE 'X%')
select movie_id as v3, v47 from cast_info as ci, aggView4096983037209559935 where ci.person_id=aggView4096983037209559935.v26);
create or replace view aggJoin8342861412614818097 as (
with aggView7688562850939385912 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView7688562850939385912 where mc.company_id=aggView7688562850939385912.v20);
create or replace view aggJoin1044242999213118045 as (
with aggView3444649876575431585 as (select v3 from aggJoin8342861412614818097 group by v3)
select id as v3 from title as t, aggView3444649876575431585 where t.id=aggView3444649876575431585.v3);
create or replace view aggJoin8840129600390974864 as (
with aggView4632190423984074758 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView4632190423984074758 where mk.keyword_id=aggView4632190423984074758.v25);
create or replace view aggJoin8176494184212847122 as (
with aggView1141497261972432287 as (select v3 from aggJoin1044242999213118045 group by v3)
select v3 from aggJoin8840129600390974864 join aggView1141497261972432287 using(v3));
create or replace view aggJoin4274042621125923496 as (
with aggView2729020968528022049 as (select v3 from aggJoin8176494184212847122 group by v3)
select v47 as v47 from aggJoin3351915758946221118 join aggView2729020968528022049 using(v3));
select MIN(v47) as v47 from aggJoin4274042621125923496;
