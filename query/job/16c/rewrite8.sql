create or replace view aggJoin8040989593204220252 as (
with aggView6781107573231750510 as (select id as v11, title as v56 from title as t where episode_nr<100)
select movie_id as v11, keyword_id as v33, v56 from movie_keyword as mk, aggView6781107573231750510 where mk.movie_id=aggView6781107573231750510.v11);
create or replace view aggJoin391539382942833256 as (
with aggView5433423699582879793 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView5433423699582879793 where an.person_id=aggView5433423699582879793.v2);
create or replace view aggJoin3179735678467965421 as (
with aggView1830378371155744071 as (select v2, MIN(v3) as v55 from aggJoin391539382942833256 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView1830378371155744071 where ci.person_id=aggView1830378371155744071.v2);
create or replace view aggJoin6529605056571573151 as (
with aggView60812472463146390 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select v11, v56 from aggJoin8040989593204220252 join aggView60812472463146390 using(v33));
create or replace view aggJoin1245647738425902390 as (
with aggView7724595988638206759 as (select v11, MIN(v56) as v56 from aggJoin6529605056571573151 group by v11,v56)
select movie_id as v11, company_id as v28, v56 from movie_companies as mc, aggView7724595988638206759 where mc.movie_id=aggView7724595988638206759.v11);
create or replace view aggJoin6246241263076959476 as (
with aggView6715774082869911746 as (select id as v28 from company_name as cn where country_code= '[us]')
select v11, v56 from aggJoin1245647738425902390 join aggView6715774082869911746 using(v28));
create or replace view aggJoin1192673831540216350 as (
with aggView7050391425475545806 as (select v11, MIN(v56) as v56 from aggJoin6246241263076959476 group by v11,v56)
select v55 as v55, v56 from aggJoin3179735678467965421 join aggView7050391425475545806 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin1192673831540216350;
