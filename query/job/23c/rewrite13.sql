create or replace view aggJoin3237249389107991115 as (
with aggView5332176959331537220 as (select id as v21, kind as v48 from kind_type as kt where kind IN ('movie','tv movie','video movie','video game'))
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView5332176959331537220 where t.kind_id=aggView5332176959331537220.v21 and production_year>1990);
create or replace view aggJoin5166321215238590813 as (
with aggView1483150984696260651 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin3237249389107991115 group by v36,v48)
select movie_id as v36, info_type_id as v16, info as v31, note as v32, v48, v49 from movie_info as mi, aggView1483150984696260651 where mi.movie_id=aggView1483150984696260651.v36 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin4404320233659699402 as (
with aggView7233821359572543812 as (select id as v16 from info_type as it1 where info= 'release dates')
select v36, v31, v32, v48, v49 from aggJoin5166321215238590813 join aggView7233821359572543812 using(v16));
create or replace view aggJoin1522188863367229157 as (
with aggView1628183466638517190 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView1628183466638517190 where mc.company_type_id=aggView1628183466638517190.v14);
create or replace view aggJoin334799559061503877 as (
with aggView3871546711777404016 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView3871546711777404016 where mk.keyword_id=aggView3871546711777404016.v18);
create or replace view aggJoin3127392622741546304 as (
with aggView1710133621380912553 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin1522188863367229157 join aggView1710133621380912553 using(v7));
create or replace view aggJoin1275544531430425905 as (
with aggView2998287097897087067 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView2998287097897087067 where cc.status_id=aggView2998287097897087067.v5);
create or replace view aggJoin7207244243898577660 as (
with aggView8328627016609385760 as (select v36 from aggJoin1275544531430425905 group by v36)
select v36 from aggJoin3127392622741546304 join aggView8328627016609385760 using(v36));
create or replace view aggJoin4537013094444023749 as (
with aggView4474129711703079241 as (select v36 from aggJoin7207244243898577660 group by v36)
select v36, v31, v32, v48 as v48, v49 as v49 from aggJoin4404320233659699402 join aggView4474129711703079241 using(v36));
create or replace view aggJoin1451890096478044052 as (
with aggView7607593739037950886 as (select v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin4537013094444023749 group by v36,v49,v48)
select v48, v49 from aggJoin334799559061503877 join aggView7607593739037950886 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin1451890096478044052;
