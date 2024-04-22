create or replace view aggJoin8608218422618661375 as (
with aggView2609922349028371960 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView2609922349028371960 where mk.keyword_id=aggView2609922349028371960.v25);
create or replace view aggJoin7446751669459577709 as (
with aggView686259459937412406 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView686259459937412406 where mc.company_id=aggView686259459937412406.v20);
create or replace view aggJoin4764520668573521453 as (
with aggView8825346222806837155 as (select v3 from aggJoin7446751669459577709 group by v3)
select id as v3 from title as t, aggView8825346222806837155 where t.id=aggView8825346222806837155.v3);
create or replace view aggJoin4271867228782134892 as (
with aggView4697892929670676748 as (select v3 from aggJoin8608218422618661375 group by v3)
select v3 from aggJoin4764520668573521453 join aggView4697892929670676748 using(v3));
create or replace view aggJoin7632969091912547889 as (
with aggView7139767781531502650 as (select v3 from aggJoin4271867228782134892 group by v3)
select person_id as v26 from cast_info as ci, aggView7139767781531502650 where ci.movie_id=aggView7139767781531502650.v3);
create or replace view aggJoin6374409139844250691 as (
with aggView318474100587457700 as (select v26 from aggJoin7632969091912547889 group by v26)
select name as v27 from name as n, aggView318474100587457700 where n.id=aggView318474100587457700.v26 and name LIKE 'X%');
create or replace view aggView451305125799497151 as select v27 from aggJoin6374409139844250691 group by v27;
select MIN(v27) as v47 from aggView451305125799497151;
