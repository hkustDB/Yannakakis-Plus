create or replace view aggJoin1762040191854854161 as (
with aggView2492597488793350286 as (select id as v53, title as v66 from title as t where production_year>=2007 and production_year<=2008 and title LIKE '%Kung%Fu%Panda%')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView2492597488793350286 where ci.movie_id=aggView2492597488793350286.v53 and note= '(voice)');
create or replace view aggJoin1948326333439243612 as (
with aggView8645597737866206029 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView8645597737866206029 where n.id=aggView8645597737866206029.v42 and gender= 'f' and name LIKE '%Angel%');
create or replace view aggJoin6251418525314845179 as (
with aggView8518592184014468101 as (select v42, MIN(v43) as v65 from aggJoin1948326333439243612 group by v42)
select v53, v9, v20, v51, v66 as v66, v65 from aggJoin1762040191854854161 join aggView8518592184014468101 using(v42));
create or replace view aggJoin4076169809540048358 as (
with aggView7074001522817597567 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v9, v20, v66, v65 from aggJoin6251418525314845179 join aggView7074001522817597567 using(v51));
create or replace view aggJoin2439046102619838521 as (
with aggView1256595301047360300 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView1256595301047360300 where mi.info_type_id=aggView1256595301047360300.v30 and ((info LIKE 'Japan:%2007%') OR (info LIKE 'USA:%2008%')));
create or replace view aggJoin3626355700247735113 as (
with aggView5118690583154168111 as (select v53 from aggJoin2439046102619838521 group by v53)
select v53, v9, v20, v66 as v66, v65 as v65 from aggJoin4076169809540048358 join aggView5118690583154168111 using(v53));
create or replace view aggJoin2615557829564200779 as (
with aggView4757118156286132232 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView4757118156286132232 where mc.company_id=aggView4757118156286132232.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin5733665189633674508 as (
with aggView8244776253073380449 as (select v53 from aggJoin2615557829564200779 group by v53)
select v9, v20, v66 as v66, v65 as v65 from aggJoin3626355700247735113 join aggView8244776253073380449 using(v53));
create or replace view aggJoin7392493664262815119 as (
with aggView7194237053776607517 as (select v9, MIN(v66) as v66, MIN(v65) as v65 from aggJoin5733665189633674508 group by v9,v65,v66)
select v66, v65 from char_name as chn, aggView7194237053776607517 where chn.id=aggView7194237053776607517.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin7392493664262815119;
