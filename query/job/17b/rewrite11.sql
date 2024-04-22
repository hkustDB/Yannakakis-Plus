create or replace view aggJoin4830944268636768281 as (
with aggView116596915546370664 as (select id as v26, name as v47 from name as n where name LIKE 'Z%')
select movie_id as v3, v47 from cast_info as ci, aggView116596915546370664 where ci.person_id=aggView116596915546370664.v26);
create or replace view aggJoin3869054808867788006 as (
with aggView5161620349325589292 as (select id as v3 from title as t)
select movie_id as v3, company_id as v20 from movie_companies as mc, aggView5161620349325589292 where mc.movie_id=aggView5161620349325589292.v3);
create or replace view aggJoin2918556881864442842 as (
with aggView4807928055184357055 as (select id as v20 from company_name as cn)
select v3 from aggJoin3869054808867788006 join aggView4807928055184357055 using(v20));
create or replace view aggJoin5152200964292633739 as (
with aggView810027825392503216 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView810027825392503216 where mk.keyword_id=aggView810027825392503216.v25);
create or replace view aggJoin310809624865242177 as (
with aggView7809165360058832033 as (select v3 from aggJoin2918556881864442842 group by v3)
select v3 from aggJoin5152200964292633739 join aggView7809165360058832033 using(v3));
create or replace view aggJoin1923312372910882411 as (
with aggView3985384548438259006 as (select v3 from aggJoin310809624865242177 group by v3)
select v47 as v47 from aggJoin4830944268636768281 join aggView3985384548438259006 using(v3));
select MIN(v47) as v47 from aggJoin1923312372910882411;
