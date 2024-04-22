create or replace view aggJoin9011989225691293114 as (
with aggView8282008240664608980 as (select id as v12, title as v31 from title as t)
select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView8282008240664608980 where mc.movie_id=aggView8282008240664608980.v12);
create or replace view aggJoin3520621067910182290 as (
with aggView2086505390307336583 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v12 from movie_keyword as mk, aggView2086505390307336583 where mk.keyword_id=aggView2086505390307336583.v18);
create or replace view aggJoin483837698729252970 as (
with aggView2669945242045510886 as (select id as v1 from company_name as cn where country_code= '[sm]')
select v12, v31 from aggJoin9011989225691293114 join aggView2669945242045510886 using(v1));
create or replace view aggJoin3496924564592238016 as (
with aggView6549996198796939599 as (select v12, MIN(v31) as v31 from aggJoin483837698729252970 group by v12,v31)
select v31 from aggJoin3520621067910182290 join aggView6549996198796939599 using(v12));
select MIN(v31) as v31 from aggJoin3496924564592238016;
