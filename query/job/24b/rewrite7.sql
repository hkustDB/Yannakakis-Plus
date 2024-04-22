create or replace view aggJoin5434587702497041284 as (
with aggView882729171023751361 as (select id as v48, name as v72 from name as n where name LIKE '%An%' and gender= 'f')
select person_id as v48, movie_id as v59, person_role_id as v9, note as v20, role_id as v57, v72 from cast_info as ci, aggView882729171023751361 where ci.person_id=aggView882729171023751361.v48 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin5593447552090871686 as (
with aggView812512582578158563 as (select id as v9, name as v71 from char_name as chn)
select v48, v59, v20, v57, v72, v71 from aggJoin5434587702497041284 join aggView812512582578158563 using(v9));
create or replace view aggJoin3541690047947179599 as (
with aggView7648211217926376244 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v59, v20, v72, v71 from aggJoin5593447552090871686 join aggView7648211217926376244 using(v57));
create or replace view aggJoin314717928446679648 as (
with aggView2598427996204183446 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView2598427996204183446 where mi.info_type_id=aggView2598427996204183446.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin7983719770178449117 as (
with aggView6618015550730658569 as (select person_id as v48 from aka_name as an group by person_id)
select v59, v20, v72 as v72, v71 as v71 from aggJoin3541690047947179599 join aggView6618015550730658569 using(v48));
create or replace view aggJoin7250520854906568064 as (
with aggView8266812248038894383 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat','computer-animated-movie'))
select movie_id as v59 from movie_keyword as mk, aggView8266812248038894383 where mk.keyword_id=aggView8266812248038894383.v32);
create or replace view aggJoin5621575521882236310 as (
with aggView2209573571393816045 as (select v59, MIN(v72) as v72, MIN(v71) as v71 from aggJoin7983719770178449117 group by v59,v72,v71)
select id as v59, title as v60, production_year as v63, v72, v71 from title as t, aggView2209573571393816045 where t.id=aggView2209573571393816045.v59 and title LIKE 'Kung Fu Panda%' and production_year>2010);
create or replace view aggJoin8307999673595809684 as (
with aggView6181405459505622678 as (select id as v23 from company_name as cn where country_code= '[us]' and name= 'DreamWorks Animation')
select movie_id as v59 from movie_companies as mc, aggView6181405459505622678 where mc.company_id=aggView6181405459505622678.v23);
create or replace view aggJoin7955997588109402599 as (
with aggView5165506383911018045 as (select v59 from aggJoin8307999673595809684 group by v59)
select v59, v43 from aggJoin314717928446679648 join aggView5165506383911018045 using(v59));
create or replace view aggJoin5803211370585982480 as (
with aggView4776351104630765218 as (select v59 from aggJoin7955997588109402599 group by v59)
select v59, v60, v63, v72 as v72, v71 as v71 from aggJoin5621575521882236310 join aggView4776351104630765218 using(v59));
create or replace view aggJoin8171985381947435812 as (
with aggView3936545253834333974 as (select v59, MIN(v72) as v72, MIN(v71) as v71, MIN(v60) as v73 from aggJoin5803211370585982480 group by v59,v72,v71)
select v72, v71, v73 from aggJoin7250520854906568064 join aggView3936545253834333974 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin8171985381947435812;
