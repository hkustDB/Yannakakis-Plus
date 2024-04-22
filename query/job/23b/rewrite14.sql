create or replace view aggJoin3016774753068103572 as (
with aggView8937484193274106107 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView8937484193274106107 where t.kind_id=aggView8937484193274106107.v21 and production_year>2000);
create or replace view aggJoin1451120120149449803 as (
with aggView4015387799547864385 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView4015387799547864385 where mc.company_type_id=aggView4015387799547864385.v14);
create or replace view aggJoin3973273492187449877 as (
with aggView6888207208247857025 as (select id as v18 from keyword as k where keyword IN ('nerd','loner','alienation','dignity'))
select movie_id as v36 from movie_keyword as mk, aggView6888207208247857025 where mk.keyword_id=aggView6888207208247857025.v18);
create or replace view aggJoin3363025329106796736 as (
with aggView5610079443417926334 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView5610079443417926334 where mi.info_type_id=aggView5610079443417926334.v16 and info LIKE 'USA:% 200%' and note LIKE '%internet%');
create or replace view aggJoin1061950976211189564 as (
with aggView5915466163728906622 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView5915466163728906622 where cc.status_id=aggView5915466163728906622.v5);
create or replace view aggJoin3161838457873598721 as (
with aggView8538593072845549291 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin1451120120149449803 join aggView8538593072845549291 using(v7));
create or replace view aggJoin9059761687584553682 as (
with aggView6287522832567536458 as (select v36 from aggJoin3161838457873598721 group by v36)
select v36, v37, v40, v48 as v48 from aggJoin3016774753068103572 join aggView6287522832567536458 using(v36));
create or replace view aggJoin5265037431888501672 as (
with aggView8136746850430888602 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin9059761687584553682 group by v36,v48)
select v36, v48, v49 from aggJoin3973273492187449877 join aggView8136746850430888602 using(v36));
create or replace view aggJoin2186081779515034527 as (
with aggView1336381199070416398 as (select v36 from aggJoin1061950976211189564 group by v36)
select v36, v31, v32 from aggJoin3363025329106796736 join aggView1336381199070416398 using(v36));
create or replace view aggJoin1530057138434551016 as (
with aggView2892938437150547135 as (select v36 from aggJoin2186081779515034527 group by v36)
select v48 as v48, v49 as v49 from aggJoin5265037431888501672 join aggView2892938437150547135 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin1530057138434551016;
