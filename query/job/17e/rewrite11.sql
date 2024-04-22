create or replace view aggJoin3366200712945294324 as (
with aggView4972784262694427195 as (select id as v26, name as v47 from name as n)
select movie_id as v3, v47 from cast_info as ci, aggView4972784262694427195 where ci.person_id=aggView4972784262694427195.v26);
create or replace view aggJoin4707822985147700003 as (
with aggView4243053748833397577 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView4243053748833397577 where mc.company_id=aggView4243053748833397577.v20);
create or replace view aggJoin1963506530907308026 as (
with aggView3789835542692803796 as (select v3 from aggJoin4707822985147700003 group by v3)
select id as v3 from title as t, aggView3789835542692803796 where t.id=aggView3789835542692803796.v3);
create or replace view aggJoin8403834134877359340 as (
with aggView7381606231896955359 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView7381606231896955359 where mk.keyword_id=aggView7381606231896955359.v25);
create or replace view aggJoin8544971096455893461 as (
with aggView8110210626685588108 as (select v3 from aggJoin1963506530907308026 group by v3)
select v3 from aggJoin8403834134877359340 join aggView8110210626685588108 using(v3));
create or replace view aggJoin7558080257041671734 as (
with aggView340482195369763776 as (select v3 from aggJoin8544971096455893461 group by v3)
select v47 as v47 from aggJoin3366200712945294324 join aggView340482195369763776 using(v3));
select MIN(v47) as v47 from aggJoin7558080257041671734;
