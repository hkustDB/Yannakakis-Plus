create or replace view aggJoin3441763048418845433 as (
with aggView6507189114618487820 as (select id as v42, name as v65 from name as n where gender= 'f')
select person_id as v42, v65 from aka_name as an, aggView6507189114618487820 where an.person_id=aggView6507189114618487820.v42);
create or replace view aggJoin5509269647695151509 as (
with aggView2415996893556333991 as (select v42, MIN(v65) as v65 from aggJoin3441763048418845433 group by v42,v65)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView2415996893556333991 where ci.person_id=aggView2415996893556333991.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin3573088971228035084 as (
with aggView6730703204447583657 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v9, v20, v65 from aggJoin5509269647695151509 join aggView6730703204447583657 using(v51));
create or replace view aggJoin4558955929381007658 as (
with aggView9190690221980378526 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView9190690221980378526 where mc.company_id=aggView9190690221980378526.v23);
create or replace view aggJoin8272907610173539864 as (
with aggView4122852474290430671 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53 from movie_info as mi, aggView4122852474290430671 where mi.info_type_id=aggView4122852474290430671.v30);
create or replace view aggJoin2283600915539028122 as (
with aggView1235198827672185869 as (select id as v9 from char_name as chn)
select v53, v20, v65 from aggJoin3573088971228035084 join aggView1235198827672185869 using(v9));
create or replace view aggJoin7371453616928416740 as (
with aggView1984343905234519538 as (select v53, MIN(v65) as v65 from aggJoin2283600915539028122 group by v53,v65)
select v53, v65 from aggJoin4558955929381007658 join aggView1984343905234519538 using(v53));
create or replace view aggJoin4725262140579244621 as (
with aggView1529614358582847561 as (select v53, MIN(v65) as v65 from aggJoin7371453616928416740 group by v53,v65)
select id as v53, title as v54, production_year as v57, v65 from title as t, aggView1529614358582847561 where t.id=aggView1529614358582847561.v53 and production_year>2000);
create or replace view aggJoin8358648072103103856 as (
with aggView8197481257388570476 as (select v53, MIN(v65) as v65, MIN(v54) as v66 from aggJoin4725262140579244621 group by v53,v65)
select v65, v66 from aggJoin8272907610173539864 join aggView8197481257388570476 using(v53));
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin8358648072103103856;
