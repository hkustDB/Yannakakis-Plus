create or replace view aggView5076833301432627893 as select id as v40, title as v41 from title as t where production_year>1990;
create or replace view aggJoin4469469434543249435 as (
with aggView8968026730272714272 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView8968026730272714272 where mc.company_id=aggView8968026730272714272.v13);
create or replace view aggJoin6412595756368867031 as (
with aggView8852888139196093756 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, note as v36 from movie_info as mi, aggView8852888139196093756 where mi.info_type_id=aggView8852888139196093756.v22 and note LIKE '%internet%');
create or replace view aggJoin4249669815081782365 as (
with aggView3113993682486320204 as (select v40 from aggJoin6412595756368867031 group by v40)
select movie_id as v40, title as v3 from aka_title as aka_t, aggView3113993682486320204 where aka_t.movie_id=aggView3113993682486320204.v40);
create or replace view aggJoin1713416481866832143 as (
with aggView2370326295449934652 as (select id as v20 from company_type as ct)
select v40 from aggJoin4469469434543249435 join aggView2370326295449934652 using(v20));
create or replace view aggJoin4993507043141538351 as (
with aggView2775101962670580208 as (select v40 from aggJoin1713416481866832143 group by v40)
select movie_id as v40, keyword_id as v24 from movie_keyword as mk, aggView2775101962670580208 where mk.movie_id=aggView2775101962670580208.v40);
create or replace view aggJoin6621055121916390339 as (
with aggView3538091944431086819 as (select id as v24 from keyword as k)
select v40 from aggJoin4993507043141538351 join aggView3538091944431086819 using(v24));
create or replace view aggJoin3140666168549489016 as (
with aggView5516117894462401576 as (select v40 from aggJoin6621055121916390339 group by v40)
select v40, v3 from aggJoin4249669815081782365 join aggView5516117894462401576 using(v40));
create or replace view aggView7471858456720672179 as select v40, v3 from aggJoin3140666168549489016 group by v40,v3;
create or replace view aggJoin9077666085666457351 as (
with aggView1570093122091530690 as (select v40, MIN(v41) as v53 from aggView5076833301432627893 group by v40)
select v3, v53 from aggView7471858456720672179 join aggView1570093122091530690 using(v40));
select MIN(v3) as v52,MIN(v53) as v53 from aggJoin9077666085666457351;
