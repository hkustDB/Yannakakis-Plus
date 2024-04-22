create or replace view aggJoin1359744127464297715 as (
with aggView814404773558164714 as (select id as v53, title as v66 from title as t where production_year>=2005 and production_year<=2009)
select movie_id as v53, company_id as v23, note as v36, v66 from movie_companies as mc, aggView814404773558164714 where mc.movie_id=aggView814404773558164714.v53 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin1674906719945888240 as (
with aggView4166778234060667399 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView4166778234060667399 where n.id=aggView4166778234060667399.v42 and name LIKE '%Ang%' and gender= 'f');
create or replace view aggJoin6464423416081820026 as (
with aggView5651681823583249056 as (select v42, MIN(v43) as v65 from aggJoin1674906719945888240 group by v42)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView5651681823583249056 where ci.person_id=aggView5651681823583249056.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin6441544688235259333 as (
with aggView5574067763350431770 as (select id as v23 from company_name as cn where country_code= '[us]')
select v53, v36, v66 from aggJoin1359744127464297715 join aggView5574067763350431770 using(v23));
create or replace view aggJoin5418653878603612275 as (
with aggView639766820629909418 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView639766820629909418 where mi.info_type_id=aggView639766820629909418.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin6744410646367694305 as (
with aggView5464439300301291823 as (select v53 from aggJoin5418653878603612275 group by v53)
select v53, v36, v66 as v66 from aggJoin6441544688235259333 join aggView5464439300301291823 using(v53));
create or replace view aggJoin5350309243874092452 as (
with aggView4846682297149323507 as (select v53, MIN(v66) as v66 from aggJoin6744410646367694305 group by v53,v66)
select v9, v20, v51, v65 as v65, v66 from aggJoin6464423416081820026 join aggView4846682297149323507 using(v53));
create or replace view aggJoin2189872472438746014 as (
with aggView8591029335042528577 as (select id as v51 from role_type as rt where role= 'actress')
select v9, v20, v65, v66 from aggJoin5350309243874092452 join aggView8591029335042528577 using(v51));
create or replace view aggJoin2745834572238675299 as (
with aggView3405673279773015990 as (select v9, MIN(v65) as v65, MIN(v66) as v66 from aggJoin2189872472438746014 group by v9,v66,v65)
select v65, v66 from char_name as chn, aggView3405673279773015990 where chn.id=aggView3405673279773015990.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin2745834572238675299;
