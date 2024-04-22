create or replace view aggJoin1432821003265033099 as (
with aggView2894902678000116094 as (select id as v9, name as v71 from char_name as chn)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView2894902678000116094 where ci.person_role_id=aggView2894902678000116094.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin1470780103438727811 as (
with aggView8480926587409884723 as (select id as v48, name as v72 from name as n where name LIKE '%An%' and gender= 'f')
select v48, v59, v20, v57, v71, v72 from aggJoin1432821003265033099 join aggView8480926587409884723 using(v48));
create or replace view aggJoin383713172501815397 as (
with aggView5231033322002809249 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView5231033322002809249 where mi.info_type_id=aggView5231033322002809249.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin7812816736875335474 as (
with aggView8622056207846863664 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v59 from movie_companies as mc, aggView8622056207846863664 where mc.company_id=aggView8622056207846863664.v23);
create or replace view aggJoin2971244862691300064 as (
with aggView8087742747892815337 as (select person_id as v48 from aka_name as an group by person_id)
select v59, v20, v57, v71 as v71, v72 as v72 from aggJoin1470780103438727811 join aggView8087742747892815337 using(v48));
create or replace view aggJoin3894662227300919007 as (
with aggView3789187237202635367 as (select id as v57 from role_type as rt where role= 'actress')
select v59, v20, v71, v72 from aggJoin2971244862691300064 join aggView3789187237202635367 using(v57));
create or replace view aggJoin5250771213988080367 as (
with aggView3430093794535333725 as (select v59, MIN(v71) as v71, MIN(v72) as v72 from aggJoin3894662227300919007 group by v59,v72,v71)
select id as v59, title as v60, production_year as v63, v71, v72 from title as t, aggView3430093794535333725 where t.id=aggView3430093794535333725.v59 and production_year>2010);
create or replace view aggJoin8990702403202914517 as (
with aggView7163753853228817647 as (select v59 from aggJoin7812816736875335474 group by v59)
select v59, v60, v63, v71 as v71, v72 as v72 from aggJoin5250771213988080367 join aggView7163753853228817647 using(v59));
create or replace view aggJoin6993069972197580068 as (
with aggView654252313764168383 as (select v59, MIN(v71) as v71, MIN(v72) as v72, MIN(v60) as v73 from aggJoin8990702403202914517 group by v59,v72,v71)
select v59, v43, v71, v72, v73 from aggJoin383713172501815397 join aggView654252313764168383 using(v59));
create or replace view aggJoin9028578604653249087 as (
with aggView8536009519237450831 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat'))
select movie_id as v59 from movie_keyword as mk, aggView8536009519237450831 where mk.keyword_id=aggView8536009519237450831.v32);
create or replace view aggJoin6152308115453570951 as (
with aggView7841514986364422005 as (select v59 from aggJoin9028578604653249087 group by v59)
select v71 as v71, v72 as v72, v73 as v73 from aggJoin6993069972197580068 join aggView7841514986364422005 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin6152308115453570951;
