create or replace view aggJoin4808936611882513926 as (
with aggView7400354710552419505 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView7400354710552419505 where ml.link_type_id=aggView7400354710552419505.v13);
create or replace view aggJoin4236360881213894860 as (
with aggView4909732708350615076 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView4909732708350615076 where mc.company_id=aggView4909732708350615076.v17);
create or replace view aggJoin3312945034886296994 as (
with aggView4916107236693269919 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView4916107236693269919 where mk.keyword_id=aggView4916107236693269919.v27);
create or replace view aggJoin1447486852901897329 as (
with aggView8011249962201338137 as (select v29, MIN(v45) as v45 from aggJoin4808936611882513926 group by v29,v45)
select movie_id as v29, info as v23, v45 from movie_info as mi, aggView8011249962201338137 where mi.movie_id=aggView8011249962201338137.v29 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German'));
create or replace view aggJoin8398323506457903070 as (
with aggView7959719663424750597 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin4236360881213894860 join aggView7959719663424750597 using(v18));
create or replace view aggJoin1350513775420319260 as (
with aggView2512739592119333230 as (select v29, MIN(v44) as v44 from aggJoin8398323506457903070 group by v29,v44)
select id as v29, title as v33, production_year as v36, v44 from title as t, aggView2512739592119333230 where t.id=aggView2512739592119333230.v29 and production_year<=2000 and production_year>=1950);
create or replace view aggJoin770083574765375822 as (
with aggView1515827418125307282 as (select v29, MIN(v45) as v45 from aggJoin1447486852901897329 group by v29,v45)
select v29, v33, v36, v44 as v44, v45 from aggJoin1350513775420319260 join aggView1515827418125307282 using(v29));
create or replace view aggJoin6495584477435630263 as (
with aggView1435308526699490125 as (select v29, MIN(v44) as v44, MIN(v45) as v45, MIN(v33) as v46 from aggJoin770083574765375822 group by v29,v44,v45)
select v44, v45, v46 from aggJoin3312945034886296994 join aggView1435308526699490125 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin6495584477435630263;
