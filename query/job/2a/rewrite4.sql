create or replace view aggJoin3640778224312854318 as (
with aggView7627506421411436163 as (select id as v1 from company_name as cn where country_code= '[de]')
select movie_id as v12 from movie_companies as mc, aggView7627506421411436163 where mc.company_id=aggView7627506421411436163.v1);
create or replace view aggJoin303944436353205179 as (
with aggView8527793551213651699 as (select v12 from aggJoin3640778224312854318 group by v12)
select id as v12, title as v20 from title as t, aggView8527793551213651699 where t.id=aggView8527793551213651699.v12);
create or replace view aggJoin2756968543392212306 as (
with aggView1766511425602178016 as (select v12, MIN(v20) as v31 from aggJoin303944436353205179 group by v12)
select keyword_id as v18, v31 from movie_keyword as mk, aggView1766511425602178016 where mk.movie_id=aggView1766511425602178016.v12);
create or replace view aggJoin3728920769159551843 as (
with aggView5544320926153852327 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select v31 from aggJoin2756968543392212306 join aggView5544320926153852327 using(v18));
select MIN(v31) as v31 from aggJoin3728920769159551843;
