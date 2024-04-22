create or replace view aggJoin1112840789385638871 as (
with aggView1286526485367751268 as (select id as v26, name as v47 from name as n where name LIKE '%Bert%')
select movie_id as v3, v47 from cast_info as ci, aggView1286526485367751268 where ci.person_id=aggView1286526485367751268.v26);
create or replace view aggJoin8797357763566955814 as (
with aggView6055358113323986526 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView6055358113323986526 where mc.company_id=aggView6055358113323986526.v20);
create or replace view aggJoin2702829375853036808 as (
with aggView6357765367782309282 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView6357765367782309282 where mk.keyword_id=aggView6357765367782309282.v25);
create or replace view aggJoin901485827709506244 as (
with aggView2644604097827705947 as (select v3 from aggJoin2702829375853036808 group by v3)
select v3 from aggJoin8797357763566955814 join aggView2644604097827705947 using(v3));
create or replace view aggJoin1673848141702441455 as (
with aggView2915702115507391613 as (select id as v3 from title as t)
select v3 from aggJoin901485827709506244 join aggView2915702115507391613 using(v3));
create or replace view aggJoin3023274909485503617 as (
with aggView8412189980605444649 as (select v3 from aggJoin1673848141702441455 group by v3)
select v47 as v47 from aggJoin1112840789385638871 join aggView8412189980605444649 using(v3));
select MIN(v47) as v47 from aggJoin3023274909485503617;
