create or replace view aggJoin5297101186667461996 as (
with aggView6444023038516589915 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView6444023038516589915 where n.id=aggView6444023038516589915.v42 and gender= 'f');
create or replace view aggJoin4131705876795749274 as (
with aggView5320806697592951563 as (select v42, v43 from aggJoin5297101186667461996 group by v42,v43)
select v42, v43 from aggView5320806697592951563 where v43 LIKE '%Angel%');
create or replace view aggJoin8843802835564931085 as (
with aggView9036350381189496915 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView9036350381189496915 where mc.company_id=aggView9036350381189496915.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin4702565934859826810 as (
with aggView4036586681220000267 as (select v53 from aggJoin8843802835564931085 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView4036586681220000267 where t.id=aggView4036586681220000267.v53 and production_year>=2007 and production_year<=2008);
create or replace view aggJoin5023236216997012521 as (
with aggView240085696824733922 as (select v54, v53 from aggJoin4702565934859826810 group by v54,v53)
select v53, v54 from aggView240085696824733922 where v54 LIKE '%Kung%Fu%Panda%');
create or replace view aggJoin6304317935369811782 as (
with aggView915375058008120509 as (select v42, MIN(v43) as v65 from aggJoin4131705876795749274 group by v42)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView915375058008120509 where ci.person_id=aggView915375058008120509.v42 and note= '(voice)');
create or replace view aggJoin5462734142274985874 as (
with aggView5870587603060437933 as (select id as v9 from char_name as chn)
select v53, v20, v51, v65 from aggJoin6304317935369811782 join aggView5870587603060437933 using(v9));
create or replace view aggJoin3834363397330179204 as (
with aggView292123890146562359 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView292123890146562359 where mi.info_type_id=aggView292123890146562359.v30 and ((info LIKE 'Japan:%2007%') OR (info LIKE 'USA:%2008%')));
create or replace view aggJoin9149490124149462557 as (
with aggView831654635067018112 as (select v53 from aggJoin3834363397330179204 group by v53)
select v53, v20, v51, v65 as v65 from aggJoin5462734142274985874 join aggView831654635067018112 using(v53));
create or replace view aggJoin6351095189431313383 as (
with aggView1905550197475116824 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v20, v65 from aggJoin9149490124149462557 join aggView1905550197475116824 using(v51));
create or replace view aggJoin6729038879725466013 as (
with aggView7670892481611856923 as (select v53, MIN(v65) as v65 from aggJoin6351095189431313383 group by v53,v65)
select v54, v65 from aggJoin5023236216997012521 join aggView7670892481611856923 using(v53));
select MIN(v65) as v65,MIN(v54) as v66 from aggJoin6729038879725466013;
