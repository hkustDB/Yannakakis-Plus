create or replace view aggJoin1168570087804876335 as (
with aggView2124485261951487773 as (select id as v53, title as v66 from title as t where production_year>2000)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView2124485261951487773 where ci.movie_id=aggView2124485261951487773.v53 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin392341937148436073 as (
with aggView7088974256773299831 as (select id as v42, name as v65 from name as n where gender= 'f')
select person_id as v42, v65 from aka_name as an, aggView7088974256773299831 where an.person_id=aggView7088974256773299831.v42);
create or replace view aggJoin6349162600975817720 as (
with aggView3350970771178184611 as (select v42, MIN(v65) as v65 from aggJoin392341937148436073 group by v42,v65)
select v53, v9, v20, v51, v66 as v66, v65 from aggJoin1168570087804876335 join aggView3350970771178184611 using(v42));
create or replace view aggJoin229488952683814045 as (
with aggView495252032285233804 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v9, v20, v66, v65 from aggJoin6349162600975817720 join aggView495252032285233804 using(v51));
create or replace view aggJoin9183095813814682182 as (
with aggView7741194119287332771 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView7741194119287332771 where mc.company_id=aggView7741194119287332771.v23);
create or replace view aggJoin2390017911713716990 as (
with aggView3269729057007104420 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53 from movie_info as mi, aggView3269729057007104420 where mi.info_type_id=aggView3269729057007104420.v30);
create or replace view aggJoin7322194585797632436 as (
with aggView2034361993900523879 as (select id as v9 from char_name as chn)
select v53, v20, v66, v65 from aggJoin229488952683814045 join aggView2034361993900523879 using(v9));
create or replace view aggJoin3571780818108508199 as (
with aggView5549687288865887060 as (select v53, MIN(v66) as v66, MIN(v65) as v65 from aggJoin7322194585797632436 group by v53,v65,v66)
select v53, v66, v65 from aggJoin9183095813814682182 join aggView5549687288865887060 using(v53));
create or replace view aggJoin8291797141178015306 as (
with aggView7129291485593736520 as (select v53, MIN(v66) as v66, MIN(v65) as v65 from aggJoin3571780818108508199 group by v53,v65,v66)
select v66, v65 from aggJoin2390017911713716990 join aggView7129291485593736520 using(v53));
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin8291797141178015306;
