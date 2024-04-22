create or replace view aggView1699527006292053385 as select id as v37, title as v41 from title as t where production_year= 1998;
create or replace view aggView2082540271305296245 as select id as v25, name as v10 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view aggJoin9082068233014748079 as (
with aggView2127986994709967499 as (select v25, MIN(v10) as v52 from aggView2082540271305296245 group by v25)
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView2127986994709967499 where mc.company_id=aggView2127986994709967499.v25);
create or replace view aggJoin1984667459815326485 as (
with aggView2590606747055650454 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Germany','Swedish','German') group by movie_id)
select movie_id as v37, subject_id as v5, status_id as v7 from complete_cast as cc, aggView2590606747055650454 where cc.movie_id=aggView2590606747055650454.v37);
create or replace view aggJoin8477821154183326050 as (
with aggView8222536536947962537 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v37, v7 from aggJoin1984667459815326485 join aggView8222536536947962537 using(v5));
create or replace view aggJoin1805750152710192742 as (
with aggView8494045765474217174 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView8494045765474217174 where mk.keyword_id=aggView8494045765474217174.v35);
create or replace view aggJoin7992194811772940966 as (
with aggView825674117587871954 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v37 from aggJoin8477821154183326050 join aggView825674117587871954 using(v7));
create or replace view aggJoin3019067200000361160 as (
with aggView4783776736216041711 as (select v37 from aggJoin1805750152710192742 group by v37)
select v37, v26, v52 as v52 from aggJoin9082068233014748079 join aggView4783776736216041711 using(v37));
create or replace view aggJoin2813106625180008958 as (
with aggView3550619090587698145 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin3019067200000361160 join aggView3550619090587698145 using(v26));
create or replace view aggJoin2282625158367578849 as (
with aggView3368235719381464243 as (select v37 from aggJoin7992194811772940966 group by v37)
select v37, v52 as v52 from aggJoin2813106625180008958 join aggView3368235719381464243 using(v37));
create or replace view aggJoin1732398394664039495 as (
with aggView3097051756369189292 as (select v37, MIN(v52) as v52 from aggJoin2282625158367578849 group by v37,v52)
select v37, v41, v52 from aggView1699527006292053385 join aggView3097051756369189292 using(v37));
create or replace view aggJoin5214359163929770092 as (
with aggView2579373573152795620 as (select v37, MIN(v52) as v52, MIN(v41) as v54 from aggJoin1732398394664039495 group by v37,v52)
select link_type_id as v21, v52, v54 from movie_link as ml, aggView2579373573152795620 where ml.movie_id=aggView2579373573152795620.v37);
create or replace view aggJoin4947140077776732641 as (
with aggView128310473139977842 as (select v21, MIN(v52) as v52, MIN(v54) as v54 from aggJoin5214359163929770092 group by v21,v52,v54)
select link as v22, v52, v54 from link_type as lt, aggView128310473139977842 where lt.id=aggView128310473139977842.v21 and link LIKE '%follow%');
select MIN(v52) as v52,MIN(v22) as v53,MIN(v54) as v54 from aggJoin4947140077776732641;
