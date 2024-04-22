create or replace view aggJoin6642946658600499807 as (
with aggView1779102126516150442 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView1779102126516150442 where ml.link_type_id=aggView1779102126516150442.v13);
create or replace view aggJoin545724714887770848 as (
with aggView5508005485666143323 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView5508005485666143323 where mc.company_id=aggView5508005485666143323.v17);
create or replace view aggJoin5492141679563633352 as (
with aggView221270313098768251 as (select id as v29, title as v46 from title as t where production_year<=2010 and production_year>=2000)
select v29, v45, v46 from aggJoin6642946658600499807 join aggView221270313098768251 using(v29));
create or replace view aggJoin3520869102275740572 as (
with aggView4808512652194209247 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView4808512652194209247 where mk.keyword_id=aggView4808512652194209247.v27);
create or replace view aggJoin2221738381559948702 as (
with aggView8247380553288048365 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin545724714887770848 join aggView8247380553288048365 using(v18));
create or replace view aggJoin290260150747477821 as (
with aggView1603342303784233266 as (select v29, MIN(v45) as v45, MIN(v46) as v46 from aggJoin5492141679563633352 group by v29,v46,v45)
select movie_id as v29, info as v23, v45, v46 from movie_info as mi, aggView1603342303784233266 where mi.movie_id=aggView1603342303784233266.v29 and info IN ('Germany','German'));
create or replace view aggJoin1307108824005145133 as (
with aggView2339589099438713329 as (select v29, MIN(v45) as v45, MIN(v46) as v46 from aggJoin290260150747477821 group by v29,v46,v45)
select v29, v44 as v44, v45, v46 from aggJoin2221738381559948702 join aggView2339589099438713329 using(v29));
create or replace view aggJoin8786713108560123426 as (
with aggView6614797543141233823 as (select v29, MIN(v44) as v44, MIN(v45) as v45, MIN(v46) as v46 from aggJoin1307108824005145133 group by v29,v46,v45,v44)
select v44, v45, v46 from aggJoin3520869102275740572 join aggView6614797543141233823 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin8786713108560123426;
