create or replace view aggView7292787976950946026 as select id as v42, name as v43 from name as n where name LIKE '%Ang%' and gender= 'f';
create or replace view aggView4315907381056414111 as select id as v53, title as v54 from title as t where production_year>=2005 and production_year<=2009;
create or replace view aggJoin4292212884675866689 as (
with aggView6644542020362542638 as (select v42, MIN(v43) as v65 from aggView7292787976950946026 group by v42)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView6644542020362542638 where ci.person_id=aggView6644542020362542638.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin5756500750276877025 as (
with aggView9022357900635010087 as (select id as v9 from char_name as chn)
select v42, v53, v20, v51, v65 from aggJoin4292212884675866689 join aggView9022357900635010087 using(v9));
create or replace view aggJoin3879521734525852793 as (
with aggView2002392718325914292 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView2002392718325914292 where mc.company_id=aggView2002392718325914292.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin1971985988734558006 as (
with aggView1066510965131947873 as (select person_id as v42 from aka_name as an group by person_id)
select v53, v20, v51, v65 as v65 from aggJoin5756500750276877025 join aggView1066510965131947873 using(v42));
create or replace view aggJoin1779164100348069664 as (
with aggView7397086160069689076 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView7397086160069689076 where mi.info_type_id=aggView7397086160069689076.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin4257672130473876075 as (
with aggView6736967129731827558 as (select v53 from aggJoin1779164100348069664 group by v53)
select v53, v36 from aggJoin3879521734525852793 join aggView6736967129731827558 using(v53));
create or replace view aggJoin8211932819362734125 as (
with aggView1635594265925735 as (select v53 from aggJoin4257672130473876075 group by v53)
select v53, v20, v51, v65 as v65 from aggJoin1971985988734558006 join aggView1635594265925735 using(v53));
create or replace view aggJoin3150258146734985945 as (
with aggView7406960671362607603 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v20, v65 from aggJoin8211932819362734125 join aggView7406960671362607603 using(v51));
create or replace view aggJoin6431220103321443740 as (
with aggView1067560920738349058 as (select v53, MIN(v65) as v65 from aggJoin3150258146734985945 group by v53,v65)
select v54, v65 from aggView4315907381056414111 join aggView1067560920738349058 using(v53));
select MIN(v65) as v65,MIN(v54) as v66 from aggJoin6431220103321443740;
