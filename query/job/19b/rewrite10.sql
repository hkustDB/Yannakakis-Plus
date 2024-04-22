create or replace view aggJoin3124603753186946557 as (
with aggView8457801830988591562 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView8457801830988591562 where n.id=aggView8457801830988591562.v42 and gender= 'f' and name LIKE '%Angel%');
create or replace view aggJoin3292201696122357596 as (
with aggView5906243297759872670 as (select v42, MIN(v43) as v65 from aggJoin3124603753186946557 group by v42)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView5906243297759872670 where ci.person_id=aggView5906243297759872670.v42 and note= '(voice)');
create or replace view aggJoin3731004443135557601 as (
with aggView8561213052624592592 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView8561213052624592592 where mc.company_id=aggView8561213052624592592.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin1628558799923952221 as (
with aggView1053404158005629109 as (select v53 from aggJoin3731004443135557601 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView1053404158005629109 where t.id=aggView1053404158005629109.v53 and production_year>=2007 and production_year<=2008 and title LIKE '%Kung%Fu%Panda%');
create or replace view aggJoin8742017071548095545 as (
with aggView6752793086239888751 as (select v53, MIN(v54) as v66 from aggJoin1628558799923952221 group by v53)
select v53, v9, v20, v51, v65 as v65, v66 from aggJoin3292201696122357596 join aggView6752793086239888751 using(v53));
create or replace view aggJoin1955506223462368066 as (
with aggView792957388661173923 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView792957388661173923 where mi.info_type_id=aggView792957388661173923.v30 and ((info LIKE 'Japan:%2007%') OR (info LIKE 'USA:%2008%')));
create or replace view aggJoin4899932481919567280 as (
with aggView5506198870017801666 as (select v53 from aggJoin1955506223462368066 group by v53)
select v9, v20, v51, v65 as v65, v66 as v66 from aggJoin8742017071548095545 join aggView5506198870017801666 using(v53));
create or replace view aggJoin7543554422954328160 as (
with aggView5117506610793928227 as (select id as v51 from role_type as rt where role= 'actress')
select v9, v20, v65, v66 from aggJoin4899932481919567280 join aggView5117506610793928227 using(v51));
create or replace view aggJoin1696808280369345153 as (
with aggView9127960653632613180 as (select v9, MIN(v65) as v65, MIN(v66) as v66 from aggJoin7543554422954328160 group by v9,v65,v66)
select v65, v66 from char_name as chn, aggView9127960653632613180 where chn.id=aggView9127960653632613180.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin1696808280369345153;
