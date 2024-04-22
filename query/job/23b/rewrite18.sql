create or replace view aggJoin7164159715363181712 as (
with aggView5629892787758497246 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView5629892787758497246 where t.kind_id=aggView5629892787758497246.v21 and production_year>2000);
create or replace view aggJoin7545902018521640363 as (
with aggView7814012014703022679 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView7814012014703022679 where mc.company_type_id=aggView7814012014703022679.v14);
create or replace view aggJoin8639018184600107283 as (
with aggView6051388353047922888 as (select id as v18 from keyword as k where keyword IN ('nerd','loner','alienation','dignity'))
select movie_id as v36 from movie_keyword as mk, aggView6051388353047922888 where mk.keyword_id=aggView6051388353047922888.v18);
create or replace view aggJoin6917608426386122863 as (
with aggView7605530554829657115 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView7605530554829657115 where mi.info_type_id=aggView7605530554829657115.v16 and info LIKE 'USA:% 200%' and note LIKE '%internet%');
create or replace view aggJoin8648897654676768063 as (
with aggView4698796410159979892 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView4698796410159979892 where cc.status_id=aggView4698796410159979892.v5);
create or replace view aggJoin7140981490664564297 as (
with aggView119590393825684918 as (select v36 from aggJoin8648897654676768063 group by v36)
select v36, v37, v40, v48 as v48 from aggJoin7164159715363181712 join aggView119590393825684918 using(v36));
create or replace view aggJoin2331694568541789309 as (
with aggView2401602422438754211 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin7140981490664564297 group by v36,v48)
select v36, v48, v49 from aggJoin8639018184600107283 join aggView2401602422438754211 using(v36));
create or replace view aggJoin782394217213085472 as (
with aggView7867637329602460123 as (select v36 from aggJoin6917608426386122863 group by v36)
select v36, v48 as v48, v49 as v49 from aggJoin2331694568541789309 join aggView7867637329602460123 using(v36));
create or replace view aggJoin4271262145203034003 as (
with aggView5029467250189426235 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin7545902018521640363 join aggView5029467250189426235 using(v7));
create or replace view aggJoin6588803136553454127 as (
with aggView7105916928265658620 as (select v36 from aggJoin4271262145203034003 group by v36)
select v48 as v48, v49 as v49 from aggJoin782394217213085472 join aggView7105916928265658620 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin6588803136553454127;
