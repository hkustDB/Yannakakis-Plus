create or replace view aggJoin940041228424356807 as (
with aggView2952386752440835290 as (select id as v42, name as v65 from name as n where name LIKE '%An%' and gender= 'f')
select person_id as v42, v65 from aka_name as an, aggView2952386752440835290 where an.person_id=aggView2952386752440835290.v42);
create or replace view aggJoin939922786932038886 as (
with aggView685842863918312880 as (select id as v51 from role_type as rt where role= 'actress')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20 from cast_info as ci, aggView685842863918312880 where ci.role_id=aggView685842863918312880.v51 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin763472042024118734 as (
with aggView5618595882775987151 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView5618595882775987151 where mi.info_type_id=aggView5618595882775987151.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin5578562088932518642 as (
with aggView5694668766802348790 as (select v42, MIN(v65) as v65 from aggJoin940041228424356807 group by v42,v65)
select v53, v9, v20, v65 from aggJoin939922786932038886 join aggView5694668766802348790 using(v42));
create or replace view aggJoin1339373545868209833 as (
with aggView7438803696668299681 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView7438803696668299681 where mc.company_id=aggView7438803696668299681.v23);
create or replace view aggJoin2969301864447625211 as (
with aggView2384298857754768374 as (select v53 from aggJoin1339373545868209833 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView2384298857754768374 where t.id=aggView2384298857754768374.v53 and production_year>2000);
create or replace view aggJoin4457145554899606726 as (
with aggView4376990481692887103 as (select v53, MIN(v54) as v66 from aggJoin2969301864447625211 group by v53)
select v53, v9, v20, v65 as v65, v66 from aggJoin5578562088932518642 join aggView4376990481692887103 using(v53));
create or replace view aggJoin2456530693813743461 as (
with aggView6889706057261484884 as (select v53 from aggJoin763472042024118734 group by v53)
select v9, v20, v65 as v65, v66 as v66 from aggJoin4457145554899606726 join aggView6889706057261484884 using(v53));
create or replace view aggJoin3297915098248677724 as (
with aggView1533995784394009937 as (select v9, MIN(v65) as v65, MIN(v66) as v66 from aggJoin2456530693813743461 group by v9,v66,v65)
select v65, v66 from char_name as chn, aggView1533995784394009937 where chn.id=aggView1533995784394009937.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin3297915098248677724;
