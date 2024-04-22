create or replace view aggJoin8190474143998404194 as (
with aggView2676179414950747484 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView2676179414950747484 where mc.company_id=aggView2676179414950747484.v13);
create or replace view aggJoin1260263232431198742 as (
with aggView3502413594563143154 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select id as v40, title as v41, production_year as v44 from title as t, aggView3502413594563143154 where t.id=aggView3502413594563143154.v40 and production_year>1990);
create or replace view aggJoin6036365571243541563 as (
with aggView1991335753768689986 as (select v40, MIN(v41) as v53 from aggJoin1260263232431198742 group by v40)
select movie_id as v40, keyword_id as v24, v53 from movie_keyword as mk, aggView1991335753768689986 where mk.movie_id=aggView1991335753768689986.v40);
create or replace view aggJoin3302742389454801335 as (
with aggView6477134937219005598 as (select id as v24 from keyword as k)
select v40, v53 from aggJoin6036365571243541563 join aggView6477134937219005598 using(v24));
create or replace view aggJoin9172159243104058371 as (
with aggView525338181512237946 as (select id as v20 from company_type as ct)
select v40 from aggJoin8190474143998404194 join aggView525338181512237946 using(v20));
create or replace view aggJoin3098828369862577698 as (
with aggView8587464884033194303 as (select v40 from aggJoin9172159243104058371 group by v40)
select movie_id as v40, info_type_id as v22, info as v35, note as v36 from movie_info as mi, aggView8587464884033194303 where mi.movie_id=aggView8587464884033194303.v40 and note LIKE '%internet%' and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')));
create or replace view aggJoin232099482724792713 as (
with aggView6589464197290809043 as (select id as v22 from info_type as it1 where info= 'release dates')
select v40, v35, v36 from aggJoin3098828369862577698 join aggView6589464197290809043 using(v22));
create or replace view aggJoin2846690673933064902 as (
with aggView1016869021114917469 as (select v40, MIN(v35) as v52 from aggJoin232099482724792713 group by v40)
select v53 as v53, v52 from aggJoin3302742389454801335 join aggView1016869021114917469 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin2846690673933064902;
