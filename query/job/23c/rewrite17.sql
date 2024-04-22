create or replace view aggJoin618499823325992131 as (
with aggView3632313384241642543 as (select id as v21, kind as v48 from kind_type as kt where kind IN ('movie','tv movie','video movie','video game'))
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView3632313384241642543 where t.kind_id=aggView3632313384241642543.v21 and production_year>1990);
create or replace view aggJoin4571664794277034105 as (
with aggView4178570117613589898 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin618499823325992131 group by v36,v48)
select movie_id as v36, keyword_id as v18, v48, v49 from movie_keyword as mk, aggView4178570117613589898 where mk.movie_id=aggView4178570117613589898.v36);
create or replace view aggJoin6283045545335476056 as (
with aggView9219775325469722605 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView9219775325469722605 where mi.info_type_id=aggView9219775325469722605.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin2487095102567459589 as (
with aggView5804207759721243696 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView5804207759721243696 where mc.company_type_id=aggView5804207759721243696.v14);
create or replace view aggJoin1130717372860699535 as (
with aggView4910888848199906871 as (select id as v18 from keyword as k)
select v36, v48, v49 from aggJoin4571664794277034105 join aggView4910888848199906871 using(v18));
create or replace view aggJoin3519329026522145161 as (
with aggView666958451826718402 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin2487095102567459589 join aggView666958451826718402 using(v7));
create or replace view aggJoin5818659583876397721 as (
with aggView7082985374585246487 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView7082985374585246487 where cc.status_id=aggView7082985374585246487.v5);
create or replace view aggJoin4947855999789371570 as (
with aggView2910644497011125559 as (select v36 from aggJoin5818659583876397721 group by v36)
select v36, v48 as v48, v49 as v49 from aggJoin1130717372860699535 join aggView2910644497011125559 using(v36));
create or replace view aggJoin2719459361666498602 as (
with aggView7552354716113275523 as (select v36 from aggJoin6283045545335476056 group by v36)
select v36 from aggJoin3519329026522145161 join aggView7552354716113275523 using(v36));
create or replace view aggJoin405571292943253799 as (
with aggView958660072517764939 as (select v36 from aggJoin2719459361666498602 group by v36)
select v48 as v48, v49 as v49 from aggJoin4947855999789371570 join aggView958660072517764939 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin405571292943253799;
