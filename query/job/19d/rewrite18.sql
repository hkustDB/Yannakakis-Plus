create or replace view aggView1645008458419701738 as select id as v53, title as v54 from title as t where production_year>2000;
create or replace view aggView6548846683059650828 as select id as v42, name as v43 from name as n where gender= 'f';
create or replace view aggJoin1930428392191241912 as (
with aggView4087706474603973155 as (select v42, MIN(v43) as v65 from aggView6548846683059650828 group by v42)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView4087706474603973155 where ci.person_id=aggView4087706474603973155.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin1098870277833926069 as (
with aggView7963730745982813239 as (select person_id as v42 from aka_name as an group by person_id)
select v53, v9, v20, v51, v65 as v65 from aggJoin1930428392191241912 join aggView7963730745982813239 using(v42));
create or replace view aggJoin5533991517297415660 as (
with aggView6813714541845468216 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v9, v20, v65 from aggJoin1098870277833926069 join aggView6813714541845468216 using(v51));
create or replace view aggJoin7025408231801494056 as (
with aggView8555081145123797090 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView8555081145123797090 where mc.company_id=aggView8555081145123797090.v23);
create or replace view aggJoin7074448069666549718 as (
with aggView7290847632142448859 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53 from movie_info as mi, aggView7290847632142448859 where mi.info_type_id=aggView7290847632142448859.v30);
create or replace view aggJoin4159817571991635908 as (
with aggView911779840313265923 as (select id as v9 from char_name as chn)
select v53, v20, v65 from aggJoin5533991517297415660 join aggView911779840313265923 using(v9));
create or replace view aggJoin3203230219672105014 as (
with aggView6277194677146130758 as (select v53 from aggJoin7025408231801494056 group by v53)
select v53 from aggJoin7074448069666549718 join aggView6277194677146130758 using(v53));
create or replace view aggJoin943860315669291629 as (
with aggView3501275075165970972 as (select v53 from aggJoin3203230219672105014 group by v53)
select v53, v20, v65 as v65 from aggJoin4159817571991635908 join aggView3501275075165970972 using(v53));
create or replace view aggJoin7251056258130386419 as (
with aggView3418381562315532490 as (select v53, MIN(v65) as v65 from aggJoin943860315669291629 group by v53,v65)
select v54, v65 from aggView1645008458419701738 join aggView3418381562315532490 using(v53));
select MIN(v65) as v65,MIN(v54) as v66 from aggJoin7251056258130386419;
