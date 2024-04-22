create or replace view aggJoin2494378170265755110 as (
with aggView4543343892961780353 as (select id as v11, title as v56 from title as t where episode_nr>=5 and episode_nr<100)
select movie_id as v11, company_id as v28, v56 from movie_companies as mc, aggView4543343892961780353 where mc.movie_id=aggView4543343892961780353.v11);
create or replace view aggJoin9200648915774251462 as (
with aggView8808495843258437684 as (select id as v28 from company_name as cn where country_code= '[us]')
select v11, v56 from aggJoin2494378170265755110 join aggView8808495843258437684 using(v28));
create or replace view aggJoin2282040405780418876 as (
with aggView3293669703249859703 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView3293669703249859703 where mk.keyword_id=aggView3293669703249859703.v33);
create or replace view aggJoin624431637278172799 as (
with aggView443586135774391473 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView443586135774391473 where an.person_id=aggView443586135774391473.v2);
create or replace view aggJoin3284343823360246706 as (
with aggView6305347763418374393 as (select v2, MIN(v3) as v55 from aggJoin624431637278172799 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView6305347763418374393 where ci.person_id=aggView6305347763418374393.v2);
create or replace view aggJoin2708533377206731217 as (
with aggView2181996505648670462 as (select v11 from aggJoin2282040405780418876 group by v11)
select v11, v56 as v56 from aggJoin9200648915774251462 join aggView2181996505648670462 using(v11));
create or replace view aggJoin7145431357297532926 as (
with aggView5108494143067645329 as (select v11, MIN(v56) as v56 from aggJoin2708533377206731217 group by v11,v56)
select v55 as v55, v56 from aggJoin3284343823360246706 join aggView5108494143067645329 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin7145431357297532926;
