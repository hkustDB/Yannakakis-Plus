create or replace view aggJoin5800431128480916305 as (
with aggView4767178706102324107 as (select id as v11, title as v56 from title as t where episode_nr>=5 and episode_nr<100)
select movie_id as v11, company_id as v28, v56 from movie_companies as mc, aggView4767178706102324107 where mc.movie_id=aggView4767178706102324107.v11);
create or replace view aggJoin6250381901763385199 as (
with aggView3647656954147897492 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView3647656954147897492 where ci.person_id=aggView3647656954147897492.v2);
create or replace view aggJoin4942103054142841536 as (
with aggView4240115538313754102 as (select id as v2 from name as n)
select v11, v55 from aggJoin6250381901763385199 join aggView4240115538313754102 using(v2));
create or replace view aggJoin4702287850799127442 as (
with aggView5964327131922339885 as (select id as v28 from company_name as cn where country_code= '[us]')
select v11, v56 from aggJoin5800431128480916305 join aggView5964327131922339885 using(v28));
create or replace view aggJoin7151724628892291397 as (
with aggView853428190411145863 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView853428190411145863 where mk.keyword_id=aggView853428190411145863.v33);
create or replace view aggJoin4605208903125952306 as (
with aggView3167677401965753003 as (select v11, MIN(v56) as v56 from aggJoin4702287850799127442 group by v11,v56)
select v11, v56 from aggJoin7151724628892291397 join aggView3167677401965753003 using(v11));
create or replace view aggJoin46844603833219508 as (
with aggView17795799965520146 as (select v11, MIN(v56) as v56 from aggJoin4605208903125952306 group by v11,v56)
select v55 as v55, v56 from aggJoin4942103054142841536 join aggView17795799965520146 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin46844603833219508;
