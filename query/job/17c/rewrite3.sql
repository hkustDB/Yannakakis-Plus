create or replace view aggJoin2593429690125665 as (
with aggView3406001698970969056 as (select id as v3 from title as t)
select movie_id as v3, company_id as v20 from movie_companies as mc, aggView3406001698970969056 where mc.movie_id=aggView3406001698970969056.v3);
create or replace view aggJoin8636523641377861078 as (
with aggView3027952347214137642 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView3027952347214137642 where mk.keyword_id=aggView3027952347214137642.v25);
create or replace view aggJoin1831972916179821943 as (
with aggView1855443665321015087 as (select v3 from aggJoin8636523641377861078 group by v3)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView1855443665321015087 where ci.movie_id=aggView1855443665321015087.v3);
create or replace view aggJoin3278771575905742738 as (
with aggView7247505701910827478 as (select id as v20 from company_name as cn)
select v3 from aggJoin2593429690125665 join aggView7247505701910827478 using(v20));
create or replace view aggJoin8336444181721475231 as (
with aggView9115577007306919126 as (select v3 from aggJoin3278771575905742738 group by v3)
select v26 from aggJoin1831972916179821943 join aggView9115577007306919126 using(v3));
create or replace view aggJoin424544176753664245 as (
with aggView2438481776348894518 as (select v26 from aggJoin8336444181721475231 group by v26)
select name as v27 from name as n, aggView2438481776348894518 where n.id=aggView2438481776348894518.v26);
create or replace view aggJoin8073104139131522365 as (
with aggView3343993994059127531 as (select v27 from aggJoin424544176753664245 group by v27)
select v27 from aggView3343993994059127531 where v27 LIKE 'X%');
select MIN(v27) as v47 from aggJoin8073104139131522365;
