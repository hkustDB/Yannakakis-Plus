create or replace view aggJoin7720094518905742620 as (
with aggView3096990580296620962 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView3096990580296620962 where mc.company_type_id=aggView3096990580296620962.v14);
create or replace view aggJoin4501800509730451897 as (
with aggView5039251354789436681 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView5039251354789436681 where mk.keyword_id=aggView5039251354789436681.v18);
create or replace view aggJoin6131573536123029139 as (
with aggView8770070464761522022 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView8770070464761522022 where mi.info_type_id=aggView8770070464761522022.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin4292287673744723137 as (
with aggView153649892021753111 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView153649892021753111 where cc.status_id=aggView153649892021753111.v5);
create or replace view aggJoin3935285260818370502 as (
with aggView2093747547560793550 as (select v36 from aggJoin4501800509730451897 group by v36)
select v36, v31, v32 from aggJoin6131573536123029139 join aggView2093747547560793550 using(v36));
create or replace view aggJoin2414961909971785594 as (
with aggView5850416464184664376 as (select v36 from aggJoin3935285260818370502 group by v36)
select v36 from aggJoin4292287673744723137 join aggView5850416464184664376 using(v36));
create or replace view aggJoin2152238701143982667 as (
with aggView4872748154543754427 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin7720094518905742620 join aggView4872748154543754427 using(v7));
create or replace view aggJoin2445308081970594535 as (
with aggView5716014875776309755 as (select v36 from aggJoin2152238701143982667 group by v36)
select v36 from aggJoin2414961909971785594 join aggView5716014875776309755 using(v36));
create or replace view aggJoin2478165334348559199 as (
with aggView3786666821143800713 as (select v36 from aggJoin2445308081970594535 group by v36)
select title as v37, kind_id as v21, production_year as v40 from title as t, aggView3786666821143800713 where t.id=aggView3786666821143800713.v36 and production_year>2000);
create or replace view aggView9121258743956844836 as select v21, v37 from aggJoin2478165334348559199 group by v21,v37;
create or replace view aggJoin7942578352016858218 as (
with aggView2413630310118845461 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select v37, v48 from aggView9121258743956844836 join aggView2413630310118845461 using(v21));
select MIN(v48) as v48,MIN(v37) as v49 from aggJoin7942578352016858218;
