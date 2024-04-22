create or replace view aggJoin7777712997901971126 as (
with aggView86326008635091222 as (select id as v37, title as v54 from title as t where production_year>=1950 and production_year<=2010)
select movie_id as v37, link_type_id as v21, v54 from movie_link as ml, aggView86326008635091222 where ml.movie_id=aggView86326008635091222.v37);
create or replace view aggJoin3100158926927243056 as (
with aggView4327568506430268266 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select v37, v54, v53 from aggJoin7777712997901971126 join aggView4327568506430268266 using(v21));
create or replace view aggJoin774184918742770302 as (
with aggView6622676051229301942 as (select id as v25, name as v52 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]')
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView6622676051229301942 where mc.company_id=aggView6622676051229301942.v25);
create or replace view aggJoin763676958709217624 as (
with aggView7402001946758949053 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView7402001946758949053 where mk.keyword_id=aggView7402001946758949053.v35);
create or replace view aggJoin8778804726023057887 as (
with aggView2935051144915272776 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView2935051144915272776 where cc.subject_id=aggView2935051144915272776.v5);
create or replace view aggJoin218892465796857092 as (
with aggView8476373388320735241 as (select v37, MIN(v54) as v54, MIN(v53) as v53 from aggJoin3100158926927243056 group by v37,v54,v53)
select v37, v26, v52 as v52, v54, v53 from aggJoin774184918742770302 join aggView8476373388320735241 using(v37));
create or replace view aggJoin8277344635641847255 as (
with aggView6529688859959263895 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select v37 from aggJoin763676958709217624 join aggView6529688859959263895 using(v37));
create or replace view aggJoin768926464857983180 as (
with aggView7423503964138432610 as (select id as v7 from comp_cast_type as cct2 where kind LIKE 'complete%')
select v37 from aggJoin8778804726023057887 join aggView7423503964138432610 using(v7));
create or replace view aggJoin7440819154104220811 as (
with aggView7083677989928144344 as (select v37 from aggJoin768926464857983180 group by v37)
select v37 from aggJoin8277344635641847255 join aggView7083677989928144344 using(v37));
create or replace view aggJoin2467930116800714938 as (
with aggView7026943798331059182 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52, v54, v53 from aggJoin218892465796857092 join aggView7026943798331059182 using(v26));
create or replace view aggJoin4383382343299872551 as (
with aggView1772186242552222300 as (select v37, MIN(v52) as v52, MIN(v54) as v54, MIN(v53) as v53 from aggJoin2467930116800714938 group by v37,v54,v52,v53)
select v52, v54, v53 from aggJoin7440819154104220811 join aggView1772186242552222300 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin4383382343299872551;
