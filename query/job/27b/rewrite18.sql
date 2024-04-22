create or replace view aggJoin8815579250452945356 as (
with aggView8463358579511639149 as (select id as v37, title as v54 from title as t where production_year= 1998)
select movie_id as v37, link_type_id as v21, v54 from movie_link as ml, aggView8463358579511639149 where ml.movie_id=aggView8463358579511639149.v37);
create or replace view aggJoin1536432648182380790 as (
with aggView5121316502702025615 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select v37, v54, v53 from aggJoin8815579250452945356 join aggView5121316502702025615 using(v21));
create or replace view aggJoin391532099763846806 as (
with aggView1010024073078460374 as (select id as v25, name as v52 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]')
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView1010024073078460374 where mc.company_id=aggView1010024073078460374.v25);
create or replace view aggJoin4258659989495835082 as (
with aggView3586501815232796119 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView3586501815232796119 where cc.subject_id=aggView3586501815232796119.v5);
create or replace view aggJoin307241733204553488 as (
with aggView5445314609404939508 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView5445314609404939508 where mk.keyword_id=aggView5445314609404939508.v35);
create or replace view aggJoin8032279425291605743 as (
with aggView2615041444239359546 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v37 from aggJoin4258659989495835082 join aggView2615041444239359546 using(v7));
create or replace view aggJoin5120150367854482541 as (
with aggView5434851030157283317 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Germany','Swedish','German') group by movie_id)
select v37, v54 as v54, v53 as v53 from aggJoin1536432648182380790 join aggView5434851030157283317 using(v37));
create or replace view aggJoin466229356316139625 as (
with aggView7170872069119063987 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin391532099763846806 join aggView7170872069119063987 using(v26));
create or replace view aggJoin4480203775360539086 as (
with aggView1237194960794060433 as (select v37, MIN(v52) as v52 from aggJoin466229356316139625 group by v37,v52)
select v37, v54 as v54, v53 as v53, v52 from aggJoin5120150367854482541 join aggView1237194960794060433 using(v37));
create or replace view aggJoin6866308934919891802 as (
with aggView1767690055097493834 as (select v37 from aggJoin8032279425291605743 group by v37)
select v37, v54 as v54, v53 as v53, v52 as v52 from aggJoin4480203775360539086 join aggView1767690055097493834 using(v37));
create or replace view aggJoin4636655754807351248 as (
with aggView6454282540844399420 as (select v37, MIN(v54) as v54, MIN(v53) as v53, MIN(v52) as v52 from aggJoin6866308934919891802 group by v37,v53,v52,v54)
select v54, v53, v52 from aggJoin307241733204553488 join aggView6454282540844399420 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin4636655754807351248;
