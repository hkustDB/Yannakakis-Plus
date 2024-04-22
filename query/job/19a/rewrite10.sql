create or replace view aggJoin40901623585342913 as (
with aggView2698480552333659990 as (select id as v53, title as v66 from title as t where production_year>=2005 and production_year<=2009)
select movie_id as v53, info_type_id as v30, info as v40, v66 from movie_info as mi, aggView2698480552333659990 where mi.movie_id=aggView2698480552333659990.v53 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin8637279772954467085 as (
with aggView4852193647140205473 as (select id as v42, name as v65 from name as n where name LIKE '%Ang%' and gender= 'f')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView4852193647140205473 where ci.person_id=aggView4852193647140205473.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin2543843258101091065 as (
with aggView2018539864568865460 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView2018539864568865460 where mc.company_id=aggView2018539864568865460.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin4235459406687037395 as (
with aggView5869498142071621272 as (select person_id as v42 from aka_name as an group by person_id)
select v53, v9, v20, v51, v65 as v65 from aggJoin8637279772954467085 join aggView5869498142071621272 using(v42));
create or replace view aggJoin8759238634930780831 as (
with aggView4846673258884321309 as (select id as v30 from info_type as it where info= 'release dates')
select v53, v40, v66 from aggJoin40901623585342913 join aggView4846673258884321309 using(v30));
create or replace view aggJoin6692860930299401861 as (
with aggView3101547979015832755 as (select v53, MIN(v66) as v66 from aggJoin8759238634930780831 group by v53,v66)
select v53, v36, v66 from aggJoin2543843258101091065 join aggView3101547979015832755 using(v53));
create or replace view aggJoin2547618539211009477 as (
with aggView1441587034742336412 as (select v53, MIN(v66) as v66 from aggJoin6692860930299401861 group by v53,v66)
select v9, v20, v51, v65 as v65, v66 from aggJoin4235459406687037395 join aggView1441587034742336412 using(v53));
create or replace view aggJoin1685605209100602001 as (
with aggView8549009605649180908 as (select id as v51 from role_type as rt where role= 'actress')
select v9, v20, v65, v66 from aggJoin2547618539211009477 join aggView8549009605649180908 using(v51));
create or replace view aggJoin9178543598779385210 as (
with aggView8185175452011677546 as (select v9, MIN(v65) as v65, MIN(v66) as v66 from aggJoin1685605209100602001 group by v9,v66,v65)
select v65, v66 from char_name as chn, aggView8185175452011677546 where chn.id=aggView8185175452011677546.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin9178543598779385210;
