create or replace view aggJoin7110140491095594109 as (
with aggView4174097076084690359 as (select id as v51 from role_type as rt where role= 'actress')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20 from cast_info as ci, aggView4174097076084690359 where ci.role_id=aggView4174097076084690359.v51 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin1247407105332285358 as (
with aggView1256769059033240695 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView1256769059033240695 where mi.info_type_id=aggView1256769059033240695.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin8470055471621203330 as (
with aggView476832470208043048 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView476832470208043048 where mc.company_id=aggView476832470208043048.v23);
create or replace view aggJoin3897238564168033504 as (
with aggView3765076357194858441 as (select id as v9 from char_name as chn)
select v42, v53, v20 from aggJoin7110140491095594109 join aggView3765076357194858441 using(v9));
create or replace view aggJoin5931215962528713744 as (
with aggView8887251290454637406 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView8887251290454637406 where n.id=aggView8887251290454637406.v42 and name LIKE '%An%' and gender= 'f');
create or replace view aggJoin2586044683388456887 as (
with aggView16516996183654011 as (select v42, MIN(v43) as v65 from aggJoin5931215962528713744 group by v42)
select v53, v20, v65 from aggJoin3897238564168033504 join aggView16516996183654011 using(v42));
create or replace view aggJoin7819458331430465423 as (
with aggView3067602565383339274 as (select v53 from aggJoin1247407105332285358 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView3067602565383339274 where t.id=aggView3067602565383339274.v53 and production_year>2000);
create or replace view aggJoin5306755122653997808 as (
with aggView7682220365840099104 as (select v53, MIN(v54) as v66 from aggJoin7819458331430465423 group by v53)
select v53, v20, v65 as v65, v66 from aggJoin2586044683388456887 join aggView7682220365840099104 using(v53));
create or replace view aggJoin5841788972915604362 as (
with aggView2852373678467813457 as (select v53, MIN(v65) as v65, MIN(v66) as v66 from aggJoin5306755122653997808 group by v53,v66,v65)
select v65, v66 from aggJoin8470055471621203330 join aggView2852373678467813457 using(v53));
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin5841788972915604362;
