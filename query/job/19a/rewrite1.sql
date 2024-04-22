create or replace view aggJoin8587169244593781830 as (
with aggView1059728765769349307 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView1059728765769349307 where n.id=aggView1059728765769349307.v42 and name LIKE '%Ang%' and gender= 'f');
create or replace view aggView7294700055124154989 as select v42, v43 from aggJoin8587169244593781830 group by v42,v43;
create or replace view aggJoin1684806838986316527 as (
with aggView2729440356287129972 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView2729440356287129972 where mc.company_id=aggView2729440356287129972.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin2187479498718741829 as (
with aggView6297079211579561432 as (select v53 from aggJoin1684806838986316527 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView6297079211579561432 where t.id=aggView6297079211579561432.v53 and production_year>=2005 and production_year<=2009);
create or replace view aggJoin7305784782147127168 as (
with aggView3757768026551598157 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView3757768026551598157 where mi.info_type_id=aggView3757768026551598157.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin5741838503547364176 as (
with aggView6232281477691848652 as (select v53 from aggJoin7305784782147127168 group by v53)
select v53, v54, v57 from aggJoin2187479498718741829 join aggView6232281477691848652 using(v53));
create or replace view aggView7934169299916295 as select v53, v54 from aggJoin5741838503547364176 group by v53,v54;
create or replace view aggJoin2476163683683981680 as (
with aggView4157637996251765346 as (select v42, MIN(v43) as v65 from aggView7294700055124154989 group by v42)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView4157637996251765346 where ci.person_id=aggView4157637996251765346.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin8426915545984741594 as (
with aggView8702444407408305730 as (select id as v9 from char_name as chn)
select v53, v20, v51, v65 from aggJoin2476163683683981680 join aggView8702444407408305730 using(v9));
create or replace view aggJoin5318424633288662011 as (
with aggView8034659094418548564 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v20, v65 from aggJoin8426915545984741594 join aggView8034659094418548564 using(v51));
create or replace view aggJoin809433180046762683 as (
with aggView7963917440720378344 as (select v53, MIN(v65) as v65 from aggJoin5318424633288662011 group by v53,v65)
select v54, v65 from aggView7934169299916295 join aggView7963917440720378344 using(v53));
select MIN(v65) as v65,MIN(v54) as v66 from aggJoin809433180046762683;
