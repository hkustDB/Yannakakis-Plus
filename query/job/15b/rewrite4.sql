create or replace view aggJoin5905120067703107489 as (
with aggView1569255314472842658 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView1569255314472842658 where mi.info_type_id=aggView1569255314472842658.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin8721030215314742918 as (
with aggView5583440860071817402 as (select v40, MIN(v35) as v52 from aggJoin5905120067703107489 group by v40)
select id as v40, title as v41, production_year as v44, v52 from title as t, aggView5583440860071817402 where t.id=aggView5583440860071817402.v40 and production_year<=2010 and production_year>=2005);
create or replace view aggJoin873904827733088578 as (
with aggView6551403397271298375 as (select id as v13 from company_name as cn where name= 'YouTube' and country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView6551403397271298375 where mc.company_id=aggView6551403397271298375.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin982863103938620274 as (
with aggView8524308333213327301 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin873904827733088578 join aggView8524308333213327301 using(v20));
create or replace view aggJoin2608879941519673310 as (
with aggView4863184210637102988 as (select v40 from aggJoin982863103938620274 group by v40)
select movie_id as v40 from aka_title as aka_t, aggView4863184210637102988 where aka_t.movie_id=aggView4863184210637102988.v40);
create or replace view aggJoin5305988305493947157 as (
with aggView699974297208470410 as (select v40 from aggJoin2608879941519673310 group by v40)
select v40, v41, v44, v52 as v52 from aggJoin8721030215314742918 join aggView699974297208470410 using(v40));
create or replace view aggJoin220449461879577772 as (
with aggView8855944954790986920 as (select v40, MIN(v52) as v52, MIN(v41) as v53 from aggJoin5305988305493947157 group by v40,v52)
select keyword_id as v24, v52, v53 from movie_keyword as mk, aggView8855944954790986920 where mk.movie_id=aggView8855944954790986920.v40);
create or replace view aggJoin1877260254883471158 as (
with aggView2560131857532040014 as (select id as v24 from keyword as k)
select v52, v53 from aggJoin220449461879577772 join aggView2560131857532040014 using(v24));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin1877260254883471158;
