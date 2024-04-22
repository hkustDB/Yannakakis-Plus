create or replace view aggJoin6689897793919455270 as (
with aggView590535816578583357 as (select id as v12, title as v31 from title as t)
select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView590535816578583357 where mc.movie_id=aggView590535816578583357.v12);
create or replace view aggJoin853376491763304898 as (
with aggView8822377245742631080 as (select id as v1 from company_name as cn where country_code= '[us]')
select v12, v31 from aggJoin6689897793919455270 join aggView8822377245742631080 using(v1));
create or replace view aggJoin8555563196813614326 as (
with aggView4986871439787566371 as (select v12, MIN(v31) as v31 from aggJoin853376491763304898 group by v12,v31)
select keyword_id as v18, v31 from movie_keyword as mk, aggView4986871439787566371 where mk.movie_id=aggView4986871439787566371.v12);
create or replace view aggJoin2171349446885476073 as (
with aggView8117245287140748498 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select v31 from aggJoin8555563196813614326 join aggView8117245287140748498 using(v18));
select MIN(v31) as v31 from aggJoin2171349446885476073;
