create or replace view aggView7791365947988010877 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin4157648844588723342 as (
with aggView1017379331563953128 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView1017379331563953128 where mk.keyword_id=aggView1017379331563953128.v27);
create or replace view aggJoin4131757634264150598 as (
with aggView349592995992527622 as (select v29 from aggJoin4157648844588723342 group by v29)
select movie_id as v29, info as v23 from movie_info as mi, aggView349592995992527622 where mi.movie_id=aggView349592995992527622.v29 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English'));
create or replace view aggJoin992719130626490368 as (
with aggView3884852682151999314 as (select v29 from aggJoin4131757634264150598 group by v29)
select id as v29, title as v33, production_year as v36 from title as t, aggView3884852682151999314 where t.id=aggView3884852682151999314.v29 and production_year<=2010 and production_year>=1950);
create or replace view aggView5331098820685371058 as select v33, v29 from aggJoin992719130626490368 group by v33,v29;
create or replace view aggJoin8205868874654119168 as (
with aggView4335165067988845436 as (select v29, MIN(v33) as v46 from aggView5331098820685371058 group by v29)
select movie_id as v29, company_id as v17, company_type_id as v18, v46 from movie_companies as mc, aggView4335165067988845436 where mc.movie_id=aggView4335165067988845436.v29);
create or replace view aggJoin3973491701606913411 as (
with aggView3828674914138850883 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView3828674914138850883 where ml.link_type_id=aggView3828674914138850883.v13);
create or replace view aggJoin5938134228493419708 as (
with aggView4330171030577401178 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v17, v46 from aggJoin8205868874654119168 join aggView4330171030577401178 using(v18));
create or replace view aggJoin3669347675319600779 as (
with aggView6682743740676702237 as (select v29, MIN(v45) as v45 from aggJoin3973491701606913411 group by v29,v45)
select v17, v46 as v46, v45 from aggJoin5938134228493419708 join aggView6682743740676702237 using(v29));
create or replace view aggJoin5484488352424179125 as (
with aggView8640673433966841474 as (select v17, MIN(v46) as v46, MIN(v45) as v45 from aggJoin3669347675319600779 group by v17,v45,v46)
select v2, v46, v45 from aggView7791365947988010877 join aggView8640673433966841474 using(v17));
select MIN(v2) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin5484488352424179125;
