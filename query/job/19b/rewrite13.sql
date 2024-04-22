create or replace view aggJoin1848509090153403392 as (
with aggView2975296070561881909 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView2975296070561881909 where n.id=aggView2975296070561881909.v42 and gender= 'f' and name LIKE '%Angel%');
create or replace view aggJoin8448281291412558422 as (
with aggView4695181949029582042 as (select v42, MIN(v43) as v65 from aggJoin1848509090153403392 group by v42)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView4695181949029582042 where ci.person_id=aggView4695181949029582042.v42 and note= '(voice)');
create or replace view aggJoin7850219428821201723 as (
with aggView6087140656464986594 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView6087140656464986594 where mc.company_id=aggView6087140656464986594.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin1937087573947268946 as (
with aggView609726297093895795 as (select v53 from aggJoin7850219428821201723 group by v53)
select v53, v9, v20, v51, v65 as v65 from aggJoin8448281291412558422 join aggView609726297093895795 using(v53));
create or replace view aggJoin2506144163641415503 as (
with aggView6686882968255625807 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView6686882968255625807 where mi.info_type_id=aggView6686882968255625807.v30 and ((info LIKE 'Japan:%2007%') OR (info LIKE 'USA:%2008%')));
create or replace view aggJoin72111653247193238 as (
with aggView886283982780544605 as (select v53 from aggJoin2506144163641415503 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView886283982780544605 where t.id=aggView886283982780544605.v53 and production_year>=2007 and production_year<=2008 and title LIKE '%Kung%Fu%Panda%');
create or replace view aggJoin3525243048407917364 as (
with aggView6248519052100580502 as (select v53, MIN(v54) as v66 from aggJoin72111653247193238 group by v53)
select v9, v20, v51, v65 as v65, v66 from aggJoin1937087573947268946 join aggView6248519052100580502 using(v53));
create or replace view aggJoin4821827360952690244 as (
with aggView8869180178324283728 as (select id as v51 from role_type as rt where role= 'actress')
select v9, v20, v65, v66 from aggJoin3525243048407917364 join aggView8869180178324283728 using(v51));
create or replace view aggJoin538764435878512204 as (
with aggView8084331367190151009 as (select v9, MIN(v65) as v65, MIN(v66) as v66 from aggJoin4821827360952690244 group by v9,v65,v66)
select v65, v66 from char_name as chn, aggView8084331367190151009 where chn.id=aggView8084331367190151009.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin538764435878512204;
