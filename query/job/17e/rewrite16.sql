create or replace view aggJoin1799119180923282800 as (
with aggView7035838834460324873 as (select id as v26, name as v47 from name as n)
select movie_id as v3, v47 from cast_info as ci, aggView7035838834460324873 where ci.person_id=aggView7035838834460324873.v26);
create or replace view aggJoin2492276166422205141 as (
with aggView5912309753868074396 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView5912309753868074396 where mc.company_id=aggView5912309753868074396.v20);
create or replace view aggJoin3366854344280852666 as (
with aggView6768291281914473438 as (select v3 from aggJoin2492276166422205141 group by v3)
select id as v3 from title as t, aggView6768291281914473438 where t.id=aggView6768291281914473438.v3);
create or replace view aggJoin2978126390603536491 as (
with aggView6379766312463483906 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView6379766312463483906 where mk.keyword_id=aggView6379766312463483906.v25);
create or replace view aggJoin4026080778060730494 as (
with aggView8015409880722797836 as (select v3 from aggJoin2978126390603536491 group by v3)
select v3 from aggJoin3366854344280852666 join aggView8015409880722797836 using(v3));
create or replace view aggJoin2935628547329999627 as (
with aggView6670098636098392419 as (select v3 from aggJoin4026080778060730494 group by v3)
select v47 as v47 from aggJoin1799119180923282800 join aggView6670098636098392419 using(v3));
select MIN(v47) as v47 from aggJoin2935628547329999627;
