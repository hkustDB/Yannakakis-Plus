create or replace view aggJoin4880474964706532184 as (
with aggView8960043927905579680 as (select id as v48, name as v72 from name as n where name LIKE '%An%' and gender= 'f')
select person_id as v48, movie_id as v59, person_role_id as v9, note as v20, role_id as v57, v72 from cast_info as ci, aggView8960043927905579680 where ci.person_id=aggView8960043927905579680.v48 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4813445334072698699 as (
with aggView8762733090103358038 as (select id as v9, name as v71 from char_name as chn)
select v48, v59, v20, v57, v72, v71 from aggJoin4880474964706532184 join aggView8762733090103358038 using(v9));
create or replace view aggJoin5761651310502150403 as (
with aggView3953396972335855534 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v59, v20, v72, v71 from aggJoin4813445334072698699 join aggView3953396972335855534 using(v57));
create or replace view aggJoin5153298139552533558 as (
with aggView4025607766531052268 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView4025607766531052268 where mi.info_type_id=aggView4025607766531052268.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin6736764864390930022 as (
with aggView1562767277247742379 as (select v59 from aggJoin5153298139552533558 group by v59)
select id as v59, title as v60, production_year as v63 from title as t, aggView1562767277247742379 where t.id=aggView1562767277247742379.v59 and title LIKE 'Kung Fu Panda%' and production_year>2010);
create or replace view aggJoin6503406962661435973 as (
with aggView3185783714787620029 as (select v59, MIN(v60) as v73 from aggJoin6736764864390930022 group by v59)
select v48, v59, v20, v72 as v72, v71 as v71, v73 from aggJoin5761651310502150403 join aggView3185783714787620029 using(v59));
create or replace view aggJoin1958051876129265532 as (
with aggView5341221157800207655 as (select person_id as v48 from aka_name as an group by person_id)
select v59, v20, v72 as v72, v71 as v71, v73 as v73 from aggJoin6503406962661435973 join aggView5341221157800207655 using(v48));
create or replace view aggJoin2298439469525528889 as (
with aggView2421662204317347942 as (select v59, MIN(v72) as v72, MIN(v71) as v71, MIN(v73) as v73 from aggJoin1958051876129265532 group by v59,v72,v71,v73)
select movie_id as v59, company_id as v23, v72, v71, v73 from movie_companies as mc, aggView2421662204317347942 where mc.movie_id=aggView2421662204317347942.v59);
create or replace view aggJoin4997651762024545682 as (
with aggView725959170411108839 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat','computer-animated-movie'))
select movie_id as v59 from movie_keyword as mk, aggView725959170411108839 where mk.keyword_id=aggView725959170411108839.v32);
create or replace view aggJoin4115873079483477659 as (
with aggView547994953940930772 as (select id as v23 from company_name as cn where country_code= '[us]' and name= 'DreamWorks Animation')
select v59, v72, v71, v73 from aggJoin2298439469525528889 join aggView547994953940930772 using(v23));
create or replace view aggJoin3416906853936217507 as (
with aggView4234367498751206916 as (select v59, MIN(v72) as v72, MIN(v71) as v71, MIN(v73) as v73 from aggJoin4115873079483477659 group by v59,v72,v71,v73)
select v72, v71, v73 from aggJoin4997651762024545682 join aggView4234367498751206916 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin3416906853936217507;
