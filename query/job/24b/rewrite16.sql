create or replace view aggJoin2430904281147033353 as (
with aggView7408870726643056481 as (select id as v48, name as v72 from name as n where name LIKE '%An%' and gender= 'f')
select person_id as v48, movie_id as v59, person_role_id as v9, note as v20, role_id as v57, v72 from cast_info as ci, aggView7408870726643056481 where ci.person_id=aggView7408870726643056481.v48 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin7517173995301054418 as (
with aggView1139215996585119793 as (select id as v9, name as v71 from char_name as chn)
select v48, v59, v20, v57, v72, v71 from aggJoin2430904281147033353 join aggView1139215996585119793 using(v9));
create or replace view aggJoin8847611523769087338 as (
with aggView4746478728160070128 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v59, v20, v72, v71 from aggJoin7517173995301054418 join aggView4746478728160070128 using(v57));
create or replace view aggJoin1598497812383504281 as (
with aggView5697496140189531411 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView5697496140189531411 where mi.info_type_id=aggView5697496140189531411.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin3345965426054642633 as (
with aggView5604553823154381271 as (select person_id as v48 from aka_name as an group by person_id)
select v59, v20, v72 as v72, v71 as v71 from aggJoin8847611523769087338 join aggView5604553823154381271 using(v48));
create or replace view aggJoin1319038600025992174 as (
with aggView5950329917528744726 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat','computer-animated-movie'))
select movie_id as v59 from movie_keyword as mk, aggView5950329917528744726 where mk.keyword_id=aggView5950329917528744726.v32);
create or replace view aggJoin4868948361357470504 as (
with aggView8336579056728220238 as (select id as v23 from company_name as cn where country_code= '[us]' and name= 'DreamWorks Animation')
select movie_id as v59 from movie_companies as mc, aggView8336579056728220238 where mc.company_id=aggView8336579056728220238.v23);
create or replace view aggJoin6133667831152003116 as (
with aggView677835762363637439 as (select v59 from aggJoin4868948361357470504 group by v59)
select id as v59, title as v60, production_year as v63 from title as t, aggView677835762363637439 where t.id=aggView677835762363637439.v59 and title LIKE 'Kung Fu Panda%' and production_year>2010);
create or replace view aggJoin8922897696316841449 as (
with aggView4302785745455651498 as (select v59, MIN(v60) as v73 from aggJoin6133667831152003116 group by v59)
select v59, v73 from aggJoin1319038600025992174 join aggView4302785745455651498 using(v59));
create or replace view aggJoin1106179329496213685 as (
with aggView689013798899824974 as (select v59 from aggJoin1598497812383504281 group by v59)
select v59, v20, v72 as v72, v71 as v71 from aggJoin3345965426054642633 join aggView689013798899824974 using(v59));
create or replace view aggJoin2810298966339015505 as (
with aggView7288561336468485678 as (select v59, MIN(v72) as v72, MIN(v71) as v71 from aggJoin1106179329496213685 group by v59,v72,v71)
select v73 as v73, v72, v71 from aggJoin8922897696316841449 join aggView7288561336468485678 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin2810298966339015505;
