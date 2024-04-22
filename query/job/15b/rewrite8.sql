create or replace view aggJoin1396099363615827175 as (
with aggView7652259677611115466 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView7652259677611115466 where mi.info_type_id=aggView7652259677611115466.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggView6628566525815975218 as select v40, v35 from aggJoin1396099363615827175 group by v40,v35;
create or replace view aggJoin2484496523035692211 as (
with aggView3851588601347983206 as (select id as v13 from company_name as cn where name= 'YouTube' and country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView3851588601347983206 where mc.company_id=aggView3851588601347983206.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin8052975091445922726 as (
with aggView1414023326271897996 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin2484496523035692211 join aggView1414023326271897996 using(v20));
create or replace view aggJoin1720284986233264178 as (
with aggView709565811622970671 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView709565811622970671 where mk.keyword_id=aggView709565811622970671.v24);
create or replace view aggJoin6556747482460879591 as (
with aggView4890243339124225847 as (select v40 from aggJoin1720284986233264178 group by v40)
select v40, v31 from aggJoin8052975091445922726 join aggView4890243339124225847 using(v40));
create or replace view aggJoin883410323902237801 as (
with aggView2960501403075184907 as (select v40 from aggJoin6556747482460879591 group by v40)
select movie_id as v40 from aka_title as aka_t, aggView2960501403075184907 where aka_t.movie_id=aggView2960501403075184907.v40);
create or replace view aggJoin8008181420078398631 as (
with aggView3408919720559218626 as (select v40 from aggJoin883410323902237801 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView3408919720559218626 where t.id=aggView3408919720559218626.v40 and production_year<=2010 and production_year>=2005);
create or replace view aggView182876164518948707 as select v40, v41 from aggJoin8008181420078398631 group by v40,v41;
create or replace view aggJoin6383050011442839133 as (
with aggView5531946611951411756 as (select v40, MIN(v41) as v53 from aggView182876164518948707 group by v40)
select v35, v53 from aggView6628566525815975218 join aggView5531946611951411756 using(v40));
select MIN(v35) as v52,MIN(v53) as v53 from aggJoin6383050011442839133;
