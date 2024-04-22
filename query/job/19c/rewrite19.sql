create or replace view aggJoin8790274356914201945 as (
with aggView267646530047300666 as (select id as v42, name as v65 from name as n where name LIKE '%An%' and gender= 'f')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView267646530047300666 where ci.person_id=aggView267646530047300666.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin8478462864415069372 as (
with aggView3661835843229280370 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v53, v9, v20, v65 from aggJoin8790274356914201945 join aggView3661835843229280370 using(v51));
create or replace view aggJoin1889293097472469881 as (
with aggView1159994039075146409 as (select person_id as v42 from aka_name as an group by person_id)
select v53, v9, v20, v65 as v65 from aggJoin8478462864415069372 join aggView1159994039075146409 using(v42));
create or replace view aggJoin6392191764651924370 as (
with aggView163251539744861817 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView163251539744861817 where mc.company_id=aggView163251539744861817.v23);
create or replace view aggJoin8194171199508264232 as (
with aggView1034909784003239365 as (select v53 from aggJoin6392191764651924370 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView1034909784003239365 where t.id=aggView1034909784003239365.v53 and production_year>2000);
create or replace view aggJoin709412585566339948 as (
with aggView7380049448655677692 as (select v53, MIN(v54) as v66 from aggJoin8194171199508264232 group by v53)
select v53, v9, v20, v65 as v65, v66 from aggJoin1889293097472469881 join aggView7380049448655677692 using(v53));
create or replace view aggJoin2959944715684707675 as (
with aggView4155401674876761351 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView4155401674876761351 where mi.info_type_id=aggView4155401674876761351.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin6277592423039993923 as (
with aggView7758370269531072495 as (select v53 from aggJoin2959944715684707675 group by v53)
select v9, v20, v65 as v65, v66 as v66 from aggJoin709412585566339948 join aggView7758370269531072495 using(v53));
create or replace view aggJoin6189992603028796488 as (
with aggView3293359536759760766 as (select v9, MIN(v65) as v65, MIN(v66) as v66 from aggJoin6277592423039993923 group by v9,v66,v65)
select v65, v66 from char_name as chn, aggView3293359536759760766 where chn.id=aggView3293359536759760766.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin6189992603028796488;
