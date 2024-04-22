create or replace view aggJoin2230768896928227251 as (
with aggView7972986564737807819 as (select id as v26, name as v47 from name as n where name LIKE '%Bert%')
select movie_id as v3, v47 from cast_info as ci, aggView7972986564737807819 where ci.person_id=aggView7972986564737807819.v26);
create or replace view aggJoin5860922442388447140 as (
with aggView8831655885736725563 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView8831655885736725563 where mc.company_id=aggView8831655885736725563.v20);
create or replace view aggJoin5569093402951630985 as (
with aggView4497829579453496478 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView4497829579453496478 where mk.keyword_id=aggView4497829579453496478.v25);
create or replace view aggJoin5978619635638598244 as (
with aggView3755032998934489373 as (select v3 from aggJoin5569093402951630985 group by v3)
select id as v3 from title as t, aggView3755032998934489373 where t.id=aggView3755032998934489373.v3);
create or replace view aggJoin5853705710494498040 as (
with aggView755220892844486067 as (select v3 from aggJoin5978619635638598244 group by v3)
select v3 from aggJoin5860922442388447140 join aggView755220892844486067 using(v3));
create or replace view aggJoin124021270119892878 as (
with aggView5631851256826025739 as (select v3 from aggJoin5853705710494498040 group by v3)
select v47 as v47 from aggJoin2230768896928227251 join aggView5631851256826025739 using(v3));
select MIN(v47) as v47 from aggJoin124021270119892878;
