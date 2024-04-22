create or replace view aggJoin1764542760741351683 as (
with aggView6870491363855182244 as (select id as v26, name as v47 from name as n where name LIKE 'B%')
select movie_id as v3, v47 from cast_info as ci, aggView6870491363855182244 where ci.person_id=aggView6870491363855182244.v26);
create or replace view aggJoin8704808819047078277 as (
with aggView6809794164532429252 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView6809794164532429252 where mc.company_id=aggView6809794164532429252.v20);
create or replace view aggJoin294075992835963196 as (
with aggView718254982122882256 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView718254982122882256 where mk.keyword_id=aggView718254982122882256.v25);
create or replace view aggJoin279598326245304465 as (
with aggView9209150760067524409 as (select v3 from aggJoin294075992835963196 group by v3)
select id as v3 from title as t, aggView9209150760067524409 where t.id=aggView9209150760067524409.v3);
create or replace view aggJoin851481160108592650 as (
with aggView7614295836583662285 as (select v3 from aggJoin279598326245304465 group by v3)
select v3 from aggJoin8704808819047078277 join aggView7614295836583662285 using(v3));
create or replace view aggJoin8197579344004931990 as (
with aggView6227188560396547965 as (select v3 from aggJoin851481160108592650 group by v3)
select v47 as v47 from aggJoin1764542760741351683 join aggView6227188560396547965 using(v3));
select MIN(v47) as v47 from aggJoin8197579344004931990;
