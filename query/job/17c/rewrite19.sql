create or replace view aggJoin3035324760838374897 as (
with aggView2643650921645875678 as (select id as v26, name as v47 from name as n where name LIKE 'X%')
select movie_id as v3, v47 from cast_info as ci, aggView2643650921645875678 where ci.person_id=aggView2643650921645875678.v26);
create or replace view aggJoin2889570871733337808 as (
with aggView5920990685164914074 as (select id as v3 from title as t)
select movie_id as v3, company_id as v20 from movie_companies as mc, aggView5920990685164914074 where mc.movie_id=aggView5920990685164914074.v3);
create or replace view aggJoin7136476262746167808 as (
with aggView3735056365569689078 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView3735056365569689078 where mk.keyword_id=aggView3735056365569689078.v25);
create or replace view aggJoin620790304807240714 as (
with aggView4137530587133596908 as (select id as v20 from company_name as cn)
select v3 from aggJoin2889570871733337808 join aggView4137530587133596908 using(v20));
create or replace view aggJoin7919316983287142382 as (
with aggView98584603165653211 as (select v3 from aggJoin7136476262746167808 group by v3)
select v3 from aggJoin620790304807240714 join aggView98584603165653211 using(v3));
create or replace view aggJoin1696197985182376664 as (
with aggView3682923625295986894 as (select v3 from aggJoin7919316983287142382 group by v3)
select v47 as v47 from aggJoin3035324760838374897 join aggView3682923625295986894 using(v3));
select MIN(v47) as v47 from aggJoin1696197985182376664;
