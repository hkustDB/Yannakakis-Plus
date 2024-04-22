create or replace view aggJoin8261647080088033268 as (
with aggView834116666778766859 as (select id as v26, name as v47 from name as n where name LIKE 'X%')
select movie_id as v3, v47 from cast_info as ci, aggView834116666778766859 where ci.person_id=aggView834116666778766859.v26);
create or replace view aggJoin8521592492819228371 as (
with aggView7384643662462513354 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView7384643662462513354 where mk.keyword_id=aggView7384643662462513354.v25);
create or replace view aggJoin1623423481164841585 as (
with aggView2242557507491389241 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView2242557507491389241 where mc.company_id=aggView2242557507491389241.v20);
create or replace view aggJoin8550258608160224057 as (
with aggView1926711149483676717 as (select v3 from aggJoin8521592492819228371 group by v3)
select id as v3 from title as t, aggView1926711149483676717 where t.id=aggView1926711149483676717.v3);
create or replace view aggJoin1185660216778735933 as (
with aggView6546213466129557483 as (select v3 from aggJoin8550258608160224057 group by v3)
select v3 from aggJoin1623423481164841585 join aggView6546213466129557483 using(v3));
create or replace view aggJoin291043303608115285 as (
with aggView691331370005145396 as (select v3 from aggJoin1185660216778735933 group by v3)
select v47 as v47 from aggJoin8261647080088033268 join aggView691331370005145396 using(v3));
select MIN(v47) as v47 from aggJoin291043303608115285;
