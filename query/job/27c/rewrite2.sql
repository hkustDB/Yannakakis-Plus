create or replace view aggView647974416795333929 as select id as v25, name as v10 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view aggJoin5733799811512001940 as (
with aggView1750190740066196031 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView1750190740066196031 where mk.keyword_id=aggView1750190740066196031.v35);
create or replace view aggJoin6951061204112660049 as (
with aggView543973258001393464 as (select v37 from aggJoin5733799811512001940 group by v37)
select movie_id as v37, info as v31 from movie_info as mi, aggView543973258001393464 where mi.movie_id=aggView543973258001393464.v37 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English'));
create or replace view aggJoin3364114355714614454 as (
with aggView5805883983002189063 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView5805883983002189063 where cc.subject_id=aggView5805883983002189063.v5);
create or replace view aggJoin2923294170409589740 as (
with aggView4615868369287188607 as (select id as v7 from comp_cast_type as cct2 where kind LIKE 'complete%')
select v37 from aggJoin3364114355714614454 join aggView4615868369287188607 using(v7));
create or replace view aggJoin6712978407533449150 as (
with aggView592599465293330651 as (select v37 from aggJoin6951061204112660049 group by v37)
select v37 from aggJoin2923294170409589740 join aggView592599465293330651 using(v37));
create or replace view aggJoin1588806073671727343 as (
with aggView828182770101199925 as (select v37 from aggJoin6712978407533449150 group by v37)
select id as v37, title as v41, production_year as v44 from title as t, aggView828182770101199925 where t.id=aggView828182770101199925.v37 and production_year>=1950 and production_year<=2010);
create or replace view aggView9009474846408591006 as select v37, v41 from aggJoin1588806073671727343 group by v37,v41;
create or replace view aggJoin8862954852255157997 as (
with aggView3815285728223465277 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView3815285728223465277 where ml.link_type_id=aggView3815285728223465277.v21);
create or replace view aggJoin6702510905229498155 as (
with aggView6815053673971142810 as (select v37, MIN(v53) as v53 from aggJoin8862954852255157997 group by v37,v53)
select v37, v41, v53 from aggView9009474846408591006 join aggView6815053673971142810 using(v37));
create or replace view aggJoin1323596847079893323 as (
with aggView3779520887531086129 as (select v37, MIN(v53) as v53, MIN(v41) as v54 from aggJoin6702510905229498155 group by v37,v53)
select company_id as v25, company_type_id as v26, v53, v54 from movie_companies as mc, aggView3779520887531086129 where mc.movie_id=aggView3779520887531086129.v37);
create or replace view aggJoin2085375280332874579 as (
with aggView3696717332401405851 as (select id as v26 from company_type as ct where kind= 'production companies')
select v25, v53, v54 from aggJoin1323596847079893323 join aggView3696717332401405851 using(v26));
create or replace view aggJoin1313016743340098047 as (
with aggView2183037884338713341 as (select v25, MIN(v53) as v53, MIN(v54) as v54 from aggJoin2085375280332874579 group by v25,v54,v53)
select v10, v53, v54 from aggView647974416795333929 join aggView2183037884338713341 using(v25));
select MIN(v10) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin1313016743340098047;
