create or replace view aggJoin8981539671088494885 as (
with aggView2290423962457300107 as (select id as v1, name as v41 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView2290423962457300107 where mc.company_id=aggView2290423962457300107.v1);
create or replace view aggJoin2223930384013588352 as (
with aggView6716551629137752626 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView6716551629137752626 where mi.info_type_id=aggView6716551629137752626.v21 and info IN ('Drama','Horror'));
create or replace view aggJoin9017308668217293295 as (
with aggView7448582695910354129 as (select v29 from aggJoin2223930384013588352 group by v29)
select movie_id as v29, info_type_id as v26, info as v27 from movie_info_idx as mi_idx, aggView7448582695910354129 where mi_idx.movie_id=aggView7448582695910354129.v29 and info>'8.0');
create or replace view aggJoin8556734212658544047 as (
with aggView7663585219352324407 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin8981539671088494885 join aggView7663585219352324407 using(v8));
create or replace view aggJoin7367943037201920567 as (
with aggView8754115409620252365 as (select id as v26 from info_type as it2 where info= 'rating')
select v29, v27 from aggJoin9017308668217293295 join aggView8754115409620252365 using(v26));
create or replace view aggJoin7970248483421275326 as (
with aggView2231849413804340371 as (select v29, MIN(v27) as v42 from aggJoin7367943037201920567 group by v29)
select id as v29, title as v30, production_year as v33, v42 from title as t, aggView2231849413804340371 where t.id=aggView2231849413804340371.v29 and production_year<=2008 and production_year>=2005);
create or replace view aggJoin5048767712716937512 as (
with aggView464625056806625432 as (select v29, MIN(v42) as v42, MIN(v30) as v43 from aggJoin7970248483421275326 group by v29,v42)
select v41 as v41, v42, v43 from aggJoin8556734212658544047 join aggView464625056806625432 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin5048767712716937512;
