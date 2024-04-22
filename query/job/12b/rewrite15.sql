create or replace view aggJoin179038863421200111 as (
with aggView1344348977776899548 as (select id as v29, title as v42 from title as t where production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%')))
select movie_id as v29, info_type_id as v26, v42 from movie_info_idx as mi_idx, aggView1344348977776899548 where mi_idx.movie_id=aggView1344348977776899548.v29);
create or replace view aggJoin3172169670834414697 as (
with aggView2240628442289430540 as (select id as v21 from info_type as it1 where info= 'budget')
select movie_id as v29, info as v22 from movie_info as mi, aggView2240628442289430540 where mi.info_type_id=aggView2240628442289430540.v21);
create or replace view aggJoin7665438510250387331 as (
with aggView5865436998820535827 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8 from movie_companies as mc, aggView5865436998820535827 where mc.company_id=aggView5865436998820535827.v1);
create or replace view aggJoin3371362270975050897 as (
with aggView5811926646273391689 as (select id as v8 from company_type as ct where kind IN ('production companies','distributors'))
select v29 from aggJoin7665438510250387331 join aggView5811926646273391689 using(v8));
create or replace view aggJoin1872565667111002760 as (
with aggView5058660481303838368 as (select v29 from aggJoin3371362270975050897 group by v29)
select v29, v26, v42 as v42 from aggJoin179038863421200111 join aggView5058660481303838368 using(v29));
create or replace view aggJoin6415554119646806316 as (
with aggView8850976520287299100 as (select id as v26 from info_type as it2 where info= 'bottom 10 rank')
select v29, v42 from aggJoin1872565667111002760 join aggView8850976520287299100 using(v26));
create or replace view aggJoin3528825475423897593 as (
with aggView2020864004634329967 as (select v29, MIN(v42) as v42 from aggJoin6415554119646806316 group by v29,v42)
select v22, v42 from aggJoin3172169670834414697 join aggView2020864004634329967 using(v29));
select MIN(v22) as v41,MIN(v42) as v42 from aggJoin3528825475423897593;
