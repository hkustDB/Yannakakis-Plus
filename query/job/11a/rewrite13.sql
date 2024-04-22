create or replace view aggJoin2168029823653027606 as (
with aggView6220721996331883526 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView6220721996331883526 where mc.company_id=aggView6220721996331883526.v17);
create or replace view aggJoin4501186362983674043 as (
with aggView8428772926534508989 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follow%')
select movie_id as v24, v40 from movie_link as ml, aggView8428772926534508989 where ml.link_type_id=aggView8428772926534508989.v13);
create or replace view aggJoin4385497422179998534 as (
with aggView2348820636404802918 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView2348820636404802918 where mk.keyword_id=aggView2348820636404802918.v22);
create or replace view aggJoin680901198323509412 as (
with aggView8126677025502893623 as (select v24, MIN(v40) as v40 from aggJoin4501186362983674043 group by v24,v40)
select v24, v18, v39 as v39, v40 from aggJoin2168029823653027606 join aggView8126677025502893623 using(v24));
create or replace view aggJoin7913075546349801567 as (
with aggView3473864094747900493 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39, v40 from aggJoin680901198323509412 join aggView3473864094747900493 using(v18));
create or replace view aggJoin6507736523506597397 as (
with aggView3628839660539435453 as (select v24, MIN(v39) as v39, MIN(v40) as v40 from aggJoin7913075546349801567 group by v24,v39,v40)
select id as v24, title as v28, production_year as v31, v39, v40 from title as t, aggView3628839660539435453 where t.id=aggView3628839660539435453.v24 and production_year<=2000 and production_year>=1950);
create or replace view aggJoin4047017843797034365 as (
with aggView6884587880444221913 as (select v24, MIN(v39) as v39, MIN(v40) as v40, MIN(v28) as v41 from aggJoin6507736523506597397 group by v24,v39,v40)
select v39, v40, v41 from aggJoin4385497422179998534 join aggView6884587880444221913 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin4047017843797034365;
