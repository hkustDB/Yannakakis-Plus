create or replace view aggJoin9096336013727910959 as (
with aggView503218591645834821 as (select id as v26, name as v47 from name as n where name LIKE 'B%')
select movie_id as v3, v47 from cast_info as ci, aggView503218591645834821 where ci.person_id=aggView503218591645834821.v26);
create or replace view aggJoin5981364847228934376 as (
with aggView7551229719518752237 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView7551229719518752237 where mc.company_id=aggView7551229719518752237.v20);
create or replace view aggJoin4797136424964434768 as (
with aggView2043260424469483353 as (select id as v3 from title as t)
select v3, v47 from aggJoin9096336013727910959 join aggView2043260424469483353 using(v3));
create or replace view aggJoin872336240748599645 as (
with aggView6188447493118658894 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView6188447493118658894 where mk.keyword_id=aggView6188447493118658894.v25);
create or replace view aggJoin157656305542666373 as (
with aggView7438155985453303523 as (select v3 from aggJoin872336240748599645 group by v3)
select v3 from aggJoin5981364847228934376 join aggView7438155985453303523 using(v3));
create or replace view aggJoin7904169353814876129 as (
with aggView8223943828075658892 as (select v3 from aggJoin157656305542666373 group by v3)
select v47 as v47 from aggJoin4797136424964434768 join aggView8223943828075658892 using(v3));
select MIN(v47) as v47 from aggJoin7904169353814876129;
