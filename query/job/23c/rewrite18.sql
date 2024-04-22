create or replace view aggJoin8557584797377677409 as (
with aggView614169026798390883 as (select id as v21, kind as v48 from kind_type as kt where kind IN ('movie','tv movie','video movie','video game'))
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView614169026798390883 where t.kind_id=aggView614169026798390883.v21 and production_year>1990);
create or replace view aggJoin7394829112128561390 as (
with aggView3864220957953374873 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView3864220957953374873 where mi.info_type_id=aggView3864220957953374873.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin3638256284904710624 as (
with aggView4619277908309262396 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView4619277908309262396 where mc.company_type_id=aggView4619277908309262396.v14);
create or replace view aggJoin3285897460762917211 as (
with aggView6591245342596482862 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView6591245342596482862 where mk.keyword_id=aggView6591245342596482862.v18);
create or replace view aggJoin4148154570548836050 as (
with aggView4504233701047057474 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin3638256284904710624 join aggView4504233701047057474 using(v7));
create or replace view aggJoin5709762000900431716 as (
with aggView601996106501182423 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView601996106501182423 where cc.status_id=aggView601996106501182423.v5);
create or replace view aggJoin5316893858188218491 as (
with aggView4639839474382767168 as (select v36 from aggJoin7394829112128561390 group by v36)
select v36 from aggJoin4148154570548836050 join aggView4639839474382767168 using(v36));
create or replace view aggJoin962230632327823527 as (
with aggView8615697688421132131 as (select v36 from aggJoin5709762000900431716 group by v36)
select v36, v37, v40, v48 as v48 from aggJoin8557584797377677409 join aggView8615697688421132131 using(v36));
create or replace view aggJoin947014885889770656 as (
with aggView5019968404420767310 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin962230632327823527 group by v36,v48)
select v36, v48, v49 from aggJoin5316893858188218491 join aggView5019968404420767310 using(v36));
create or replace view aggJoin5573241492341814914 as (
with aggView2415552821374965892 as (select v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin947014885889770656 group by v36,v49,v48)
select v48, v49 from aggJoin3285897460762917211 join aggView2415552821374965892 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin5573241492341814914;
