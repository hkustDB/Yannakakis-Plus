create or replace view aggJoin8297946756066265642 as (
with aggView3098948054562428612 as (select id as v53, title as v66 from title as t where production_year>=2007 and production_year<=2008 and title LIKE '%Kung%Fu%Panda%')
select movie_id as v53, info_type_id as v30, info as v40, v66 from movie_info as mi, aggView3098948054562428612 where mi.movie_id=aggView3098948054562428612.v53 and ((info LIKE 'Japan:%2007%') OR (info LIKE 'USA:%2008%')));
create or replace view aggJoin8221295836788764442 as (
with aggView913613544743397407 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView913613544743397407 where n.id=aggView913613544743397407.v42 and gender= 'f' and name LIKE '%Angel%');
create or replace view aggJoin3654810245891732433 as (
with aggView4188600269096407954 as (select v42, MIN(v43) as v65 from aggJoin8221295836788764442 group by v42)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView4188600269096407954 where ci.person_id=aggView4188600269096407954.v42 and note= '(voice)');
create or replace view aggJoin9140269829174500932 as (
with aggView8302280136813889242 as (select id as v30 from info_type as it where info= 'release dates')
select v53, v40, v66 from aggJoin8297946756066265642 join aggView8302280136813889242 using(v30));
create or replace view aggJoin484932464653872526 as (
with aggView1997126732449043280 as (select v53, MIN(v66) as v66 from aggJoin9140269829174500932 group by v53,v66)
select movie_id as v53, company_id as v23, note as v36, v66 from movie_companies as mc, aggView1997126732449043280 where mc.movie_id=aggView1997126732449043280.v53 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin5680673021544383433 as (
with aggView1032640779331418309 as (select id as v23 from company_name as cn where country_code= '[us]')
select v53, v36, v66 from aggJoin484932464653872526 join aggView1032640779331418309 using(v23));
create or replace view aggJoin2429109368848989927 as (
with aggView1273336186451720604 as (select v53, MIN(v66) as v66 from aggJoin5680673021544383433 group by v53,v66)
select v9, v20, v51, v65 as v65, v66 from aggJoin3654810245891732433 join aggView1273336186451720604 using(v53));
create or replace view aggJoin6027450048593564105 as (
with aggView5225967854075250540 as (select id as v51 from role_type as rt where role= 'actress')
select v9, v20, v65, v66 from aggJoin2429109368848989927 join aggView5225967854075250540 using(v51));
create or replace view aggJoin1755048247576342154 as (
with aggView7395159490216590648 as (select v9, MIN(v65) as v65, MIN(v66) as v66 from aggJoin6027450048593564105 group by v9,v65,v66)
select v65, v66 from char_name as chn, aggView7395159490216590648 where chn.id=aggView7395159490216590648.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin1755048247576342154;
