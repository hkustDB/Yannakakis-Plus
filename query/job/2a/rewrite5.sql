create or replace view aggJoin7562701107284569681 as (
with aggView4588523655474777056 as (select id as v12, title as v31 from title as t)
select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView4588523655474777056 where mk.movie_id=aggView4588523655474777056.v12);
create or replace view aggJoin4321770235980932010 as (
with aggView1412423821949499577 as (select id as v1 from company_name as cn where country_code= '[de]')
select movie_id as v12 from movie_companies as mc, aggView1412423821949499577 where mc.company_id=aggView1412423821949499577.v1);
create or replace view aggJoin8003012414753984350 as (
with aggView1732061303385306941 as (select v12 from aggJoin4321770235980932010 group by v12)
select v18, v31 as v31 from aggJoin7562701107284569681 join aggView1732061303385306941 using(v12));
create or replace view aggJoin8846653209386757756 as (
with aggView6386002861626957865 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select v31 from aggJoin8003012414753984350 join aggView6386002861626957865 using(v18));
select MIN(v31) as v31 from aggJoin8846653209386757756;
