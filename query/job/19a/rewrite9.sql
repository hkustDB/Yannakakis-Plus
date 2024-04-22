create or replace view aggJoin8737389385413249729 as (
with aggView6452622054260392172 as (select id as v42, name as v43 from name as n where gender= 'f')
select v42, v43 from aggView6452622054260392172 where v43 LIKE '%Ang%');
create or replace view aggJoin2031835514350181294 as (
with aggView2608109272710846888 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView2608109272710846888 where mc.company_id=aggView2608109272710846888.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin1277606587909630566 as (
with aggView4382866587227112218 as (select v53 from aggJoin2031835514350181294 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView4382866587227112218 where t.id=aggView4382866587227112218.v53 and production_year>=2005 and production_year<=2009);
create or replace view aggJoin9175164529361975565 as (
with aggView4208420330026487284 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView4208420330026487284 where mi.info_type_id=aggView4208420330026487284.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin3432511611656138547 as (
with aggView8093321566801052408 as (select v53 from aggJoin9175164529361975565 group by v53)
select v53, v54, v57 from aggJoin1277606587909630566 join aggView8093321566801052408 using(v53));
create or replace view aggView8816599235900081501 as select v53, v54 from aggJoin3432511611656138547 group by v53,v54;
create or replace view aggJoin3614526759514699406 as (
with aggView6198204306733721368 as (select v53, MIN(v54) as v66 from aggView8816599235900081501 group by v53)
select person_id as v42, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView6198204306733721368 where ci.movie_id=aggView6198204306733721368.v53 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin120994420739178338 as (
with aggView8913464920959857544 as (select id as v9 from char_name as chn)
select v42, v20, v51, v66 from aggJoin3614526759514699406 join aggView8913464920959857544 using(v9));
create or replace view aggJoin3549390860329527672 as (
with aggView6297380248189293543 as (select person_id as v42 from aka_name as an group by person_id)
select v42, v20, v51, v66 as v66 from aggJoin120994420739178338 join aggView6297380248189293543 using(v42));
create or replace view aggJoin6155607915397999921 as (
with aggView9159973315977433769 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v20, v66 from aggJoin3549390860329527672 join aggView9159973315977433769 using(v51));
create or replace view aggJoin5422917591251185583 as (
with aggView6285668228404342234 as (select v42, MIN(v66) as v66 from aggJoin6155607915397999921 group by v42,v66)
select v43, v66 from aggJoin8737389385413249729 join aggView6285668228404342234 using(v42));
select MIN(v43) as v65,MIN(v66) as v66 from aggJoin5422917591251185583;
