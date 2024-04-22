create or replace view aggView1476941806137804673 as select id as v25, name as v10 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view aggJoin1780598360411625704 as (
with aggView1904576952869393758 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView1904576952869393758 where mk.keyword_id=aggView1904576952869393758.v35);
create or replace view aggJoin4223677293768754737 as (
with aggView179342438159567459 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView179342438159567459 where cc.subject_id=aggView179342438159567459.v5);
create or replace view aggJoin7313292409080101858 as (
with aggView7252400476522003097 as (select id as v7 from comp_cast_type as cct2 where kind LIKE 'complete%')
select v37 from aggJoin4223677293768754737 join aggView7252400476522003097 using(v7));
create or replace view aggJoin8282416234251982016 as (
with aggView254875074320049774 as (select v37 from aggJoin7313292409080101858 group by v37)
select v37 from aggJoin1780598360411625704 join aggView254875074320049774 using(v37));
create or replace view aggJoin2688534234321291711 as (
with aggView3289178658322691312 as (select v37 from aggJoin8282416234251982016 group by v37)
select id as v37, title as v41, production_year as v44 from title as t, aggView3289178658322691312 where t.id=aggView3289178658322691312.v37 and production_year>=1950 and production_year<=2010);
create or replace view aggView6270442083543708587 as select v37, v41 from aggJoin2688534234321291711 group by v37,v41;
create or replace view aggJoin7501938544400212416 as (
with aggView1465972274448107118 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView1465972274448107118 where ml.link_type_id=aggView1465972274448107118.v21);
create or replace view aggJoin7367849375963228092 as (
with aggView2732145234960501045 as (select v25, MIN(v10) as v52 from aggView1476941806137804673 group by v25)
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView2732145234960501045 where mc.company_id=aggView2732145234960501045.v25);
create or replace view aggJoin6260224470151109219 as (
with aggView3091891580437964918 as (select v37, MIN(v53) as v53 from aggJoin7501938544400212416 group by v37,v53)
select v37, v26, v52 as v52, v53 from aggJoin7367849375963228092 join aggView3091891580437964918 using(v37));
create or replace view aggJoin3903246294288651152 as (
with aggView1082671174921052692 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select v37, v26, v52 as v52, v53 as v53 from aggJoin6260224470151109219 join aggView1082671174921052692 using(v37));
create or replace view aggJoin4976304218667596800 as (
with aggView7560824327285321750 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52, v53 from aggJoin3903246294288651152 join aggView7560824327285321750 using(v26));
create or replace view aggJoin1038098846839302580 as (
with aggView7682843961072361215 as (select v37, MIN(v52) as v52, MIN(v53) as v53 from aggJoin4976304218667596800 group by v37,v52,v53)
select v41, v52, v53 from aggView6270442083543708587 join aggView7682843961072361215 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v41) as v54 from aggJoin1038098846839302580;
