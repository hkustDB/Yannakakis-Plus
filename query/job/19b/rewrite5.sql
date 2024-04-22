create or replace view aggJoin4857982915973475626 as (
with aggView7876800403073867537 as (select id as v42, name as v65 from name as n where gender= 'f' and name LIKE '%Angel%')
select person_id as v42, v65 from aka_name as an, aggView7876800403073867537 where an.person_id=aggView7876800403073867537.v42);
create or replace view aggJoin3786184363955584541 as (
with aggView2714170156636173513 as (select v42, MIN(v65) as v65 from aggJoin4857982915973475626 group by v42,v65)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView2714170156636173513 where ci.person_id=aggView2714170156636173513.v42 and note= '(voice)');
create or replace view aggJoin1800661933162480237 as (
with aggView4466197141349053873 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView4466197141349053873 where mc.company_id=aggView4466197141349053873.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin4829116640701649325 as (
with aggView3227185820539115222 as (select v53 from aggJoin1800661933162480237 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView3227185820539115222 where t.id=aggView3227185820539115222.v53 and production_year>=2007 and production_year<=2008 and title LIKE '%Kung%Fu%Panda%');
create or replace view aggJoin8964179687278213852 as (
with aggView4093001490488327927 as (select v53, MIN(v54) as v66 from aggJoin4829116640701649325 group by v53)
select movie_id as v53, info_type_id as v30, info as v40, v66 from movie_info as mi, aggView4093001490488327927 where mi.movie_id=aggView4093001490488327927.v53 and ((info LIKE 'Japan:%2007%') OR (info LIKE 'USA:%2008%')));
create or replace view aggJoin7952069912354223277 as (
with aggView7290804625696196471 as (select id as v30 from info_type as it where info= 'release dates')
select v53, v40, v66 from aggJoin8964179687278213852 join aggView7290804625696196471 using(v30));
create or replace view aggJoin6729331889269843157 as (
with aggView8104270242819190556 as (select v53, MIN(v66) as v66 from aggJoin7952069912354223277 group by v53,v66)
select v9, v20, v51, v65 as v65, v66 from aggJoin3786184363955584541 join aggView8104270242819190556 using(v53));
create or replace view aggJoin2016829300013156016 as (
with aggView4033514158796653953 as (select id as v51 from role_type as rt where role= 'actress')
select v9, v20, v65, v66 from aggJoin6729331889269843157 join aggView4033514158796653953 using(v51));
create or replace view aggJoin4477682533487553295 as (
with aggView6381959510133836824 as (select v9, MIN(v65) as v65, MIN(v66) as v66 from aggJoin2016829300013156016 group by v9,v65,v66)
select v65, v66 from char_name as chn, aggView6381959510133836824 where chn.id=aggView6381959510133836824.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin4477682533487553295;
