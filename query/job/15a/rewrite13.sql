create or replace view aggJoin5495462610546672158 as (
with aggView6101344183975845538 as (select id as v40, title as v53 from title as t where production_year>2000)
select movie_id as v40, v53 from aka_title as aka_t, aggView6101344183975845538 where aka_t.movie_id=aggView6101344183975845538.v40);
create or replace view aggJoin3211447458063413989 as (
with aggView4506437090786503807 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView4506437090786503807 where mk.keyword_id=aggView4506437090786503807.v24);
create or replace view aggJoin5620345466516402329 as (
with aggView551085626858179277 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView551085626858179277 where mc.company_id=aggView551085626858179277.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin8168575441151279242 as (
with aggView3392144853056897382 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin5620345466516402329 join aggView3392144853056897382 using(v20));
create or replace view aggJoin889301065957791003 as (
with aggView2374518846612327083 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView2374518846612327083 where mi.info_type_id=aggView2374518846612327083.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin26609707991663479 as (
with aggView5309641999277384445 as (select v40, MIN(v53) as v53 from aggJoin5495462610546672158 group by v40,v53)
select v40, v35, v36, v53 from aggJoin889301065957791003 join aggView5309641999277384445 using(v40));
create or replace view aggJoin4534077460979088305 as (
with aggView272011647654204027 as (select v40, MIN(v53) as v53, MIN(v35) as v52 from aggJoin26609707991663479 group by v40,v53)
select v40, v31, v53, v52 from aggJoin8168575441151279242 join aggView272011647654204027 using(v40));
create or replace view aggJoin1012094477719723498 as (
with aggView5462778717092255716 as (select v40, MIN(v53) as v53, MIN(v52) as v52 from aggJoin4534077460979088305 group by v40,v53,v52)
select v53, v52 from aggJoin3211447458063413989 join aggView5462778717092255716 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin1012094477719723498;
