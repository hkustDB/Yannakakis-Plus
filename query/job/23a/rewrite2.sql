create or replace view aggJoin3425481000728399590 as (
with aggView4669976382627423761 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView4669976382627423761 where mc.company_type_id=aggView4669976382627423761.v14);
create or replace view aggJoin2604300437417173863 as (
with aggView2758638453363259827 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView2758638453363259827 where mk.keyword_id=aggView2758638453363259827.v18);
create or replace view aggJoin2673805165830885258 as (
with aggView8108510263043776198 as (select v36 from aggJoin2604300437417173863 group by v36)
select v36, v7 from aggJoin3425481000728399590 join aggView8108510263043776198 using(v36));
create or replace view aggJoin9108229432280870524 as (
with aggView3491700849624496776 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView3491700849624496776 where mi.info_type_id=aggView3491700849624496776.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin688230847020456185 as (
with aggView4834989530549312969 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView4834989530549312969 where cc.status_id=aggView4834989530549312969.v5);
create or replace view aggJoin4093888512219349240 as (
with aggView792480053855084204 as (select v36 from aggJoin688230847020456185 group by v36)
select id as v36, title as v37, kind_id as v21, production_year as v40 from title as t, aggView792480053855084204 where t.id=aggView792480053855084204.v36 and production_year>2000);
create or replace view aggJoin1342474478099528690 as (
with aggView9188992221110060118 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin2673805165830885258 join aggView9188992221110060118 using(v7));
create or replace view aggJoin5055095656777844913 as (
with aggView671421928243221972 as (select v36 from aggJoin1342474478099528690 group by v36)
select v36, v31, v32 from aggJoin9108229432280870524 join aggView671421928243221972 using(v36));
create or replace view aggJoin5960572760652027717 as (
with aggView7409316936473442542 as (select v36 from aggJoin5055095656777844913 group by v36)
select v37, v21, v40 from aggJoin4093888512219349240 join aggView7409316936473442542 using(v36));
create or replace view aggView6861128254878695127 as select v21, v37 from aggJoin5960572760652027717 group by v21,v37;
create or replace view aggJoin8274703472034818951 as (
with aggView163437623556878334 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select v37, v48 from aggView6861128254878695127 join aggView163437623556878334 using(v21));
select MIN(v48) as v48,MIN(v37) as v49 from aggJoin8274703472034818951;
