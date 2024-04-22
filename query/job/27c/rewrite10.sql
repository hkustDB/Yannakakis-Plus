create or replace view aggJoin8011607784818189344 as (
with aggView3374508724174735332 as (select id as v37, title as v54 from title as t where production_year>=1950 and production_year<=2010)
select movie_id as v37, link_type_id as v21, v54 from movie_link as ml, aggView3374508724174735332 where ml.movie_id=aggView3374508724174735332.v37);
create or replace view aggJoin5957028381016177374 as (
with aggView2843597468652532757 as (select id as v25, name as v52 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]')
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView2843597468652532757 where mc.company_id=aggView2843597468652532757.v25);
create or replace view aggJoin6863153755577025847 as (
with aggView4514240542182816692 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select v37, v54, v53 from aggJoin8011607784818189344 join aggView4514240542182816692 using(v21));
create or replace view aggJoin229011118498601966 as (
with aggView3491982702007733352 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView3491982702007733352 where mk.keyword_id=aggView3491982702007733352.v35);
create or replace view aggJoin8807960660046644940 as (
with aggView7572123592887081216 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView7572123592887081216 where cc.subject_id=aggView7572123592887081216.v5);
create or replace view aggJoin7001196832791899274 as (
with aggView4453325687014180090 as (select id as v7 from comp_cast_type as cct2 where kind LIKE 'complete%')
select v37 from aggJoin8807960660046644940 join aggView4453325687014180090 using(v7));
create or replace view aggJoin8920384857747019049 as (
with aggView9090213224955691439 as (select v37, MIN(v54) as v54, MIN(v53) as v53 from aggJoin6863153755577025847 group by v37,v54,v53)
select v37, v54, v53 from aggJoin229011118498601966 join aggView9090213224955691439 using(v37));
create or replace view aggJoin6336350984778913277 as (
with aggView7078689183846653708 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select v37 from aggJoin7001196832791899274 join aggView7078689183846653708 using(v37));
create or replace view aggJoin4795852625858136034 as (
with aggView2387926123663241346 as (select v37 from aggJoin6336350984778913277 group by v37)
select v37, v26, v52 as v52 from aggJoin5957028381016177374 join aggView2387926123663241346 using(v37));
create or replace view aggJoin6347423318514005126 as (
with aggView188926924970321420 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin4795852625858136034 join aggView188926924970321420 using(v26));
create or replace view aggJoin6703301482721435813 as (
with aggView2384797367332108071 as (select v37, MIN(v52) as v52 from aggJoin6347423318514005126 group by v37,v52)
select v54 as v54, v53 as v53, v52 from aggJoin8920384857747019049 join aggView2384797367332108071 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin6703301482721435813;
