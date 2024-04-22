create or replace view aggJoin5297560706989849267 as (
with aggView8423629905832917875 as (select id as v48, name as v72 from name as n where name LIKE '%An%' and gender= 'f')
select person_id as v48, movie_id as v59, person_role_id as v9, note as v20, role_id as v57, v72 from cast_info as ci, aggView8423629905832917875 where ci.person_id=aggView8423629905832917875.v48 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin1490738276589713479 as (
with aggView3016352691342940289 as (select id as v9, name as v71 from char_name as chn)
select v48, v59, v20, v57, v72, v71 from aggJoin5297560706989849267 join aggView3016352691342940289 using(v9));
create or replace view aggJoin6657412011644728277 as (
with aggView3337164126569068387 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v59, v20, v72, v71 from aggJoin1490738276589713479 join aggView3337164126569068387 using(v57));
create or replace view aggJoin6934822126489406281 as (
with aggView4206674873742552357 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView4206674873742552357 where mi.info_type_id=aggView4206674873742552357.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin6006856422963721253 as (
with aggView5124547887719029484 as (select v59 from aggJoin6934822126489406281 group by v59)
select id as v59, title as v60, production_year as v63 from title as t, aggView5124547887719029484 where t.id=aggView5124547887719029484.v59 and title LIKE 'Kung Fu Panda%' and production_year>2010);
create or replace view aggJoin8047963817769786160 as (
with aggView6864465857669491972 as (select person_id as v48 from aka_name as an group by person_id)
select v59, v20, v72 as v72, v71 as v71 from aggJoin6657412011644728277 join aggView6864465857669491972 using(v48));
create or replace view aggJoin6095604035259354561 as (
with aggView3987059723531125683 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat','computer-animated-movie'))
select movie_id as v59 from movie_keyword as mk, aggView3987059723531125683 where mk.keyword_id=aggView3987059723531125683.v32);
create or replace view aggJoin9189865705575928943 as (
with aggView3046222498527566013 as (select v59, MIN(v72) as v72, MIN(v71) as v71 from aggJoin8047963817769786160 group by v59,v72,v71)
select v59, v60, v63, v72, v71 from aggJoin6006856422963721253 join aggView3046222498527566013 using(v59));
create or replace view aggJoin7718864557508953894 as (
with aggView6703164826938565167 as (select id as v23 from company_name as cn where country_code= '[us]' and name= 'DreamWorks Animation')
select movie_id as v59 from movie_companies as mc, aggView6703164826938565167 where mc.company_id=aggView6703164826938565167.v23);
create or replace view aggJoin4787664812825753321 as (
with aggView7700438341223162183 as (select v59 from aggJoin7718864557508953894 group by v59)
select v59, v60, v63, v72 as v72, v71 as v71 from aggJoin9189865705575928943 join aggView7700438341223162183 using(v59));
create or replace view aggJoin5694599059967695306 as (
with aggView1337683740484669605 as (select v59, MIN(v72) as v72, MIN(v71) as v71, MIN(v60) as v73 from aggJoin4787664812825753321 group by v59,v72,v71)
select v72, v71, v73 from aggJoin6095604035259354561 join aggView1337683740484669605 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin5694599059967695306;
