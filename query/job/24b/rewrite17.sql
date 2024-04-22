create or replace view aggView3689517074779280171 as select id as v9, name as v10 from char_name as chn;
create or replace view aggJoin455334898569907601 as (
with aggView6602546630195855805 as (select id as v59, title as v60 from title as t where production_year>2010)
select v59, v60 from aggView6602546630195855805 where v60 LIKE 'Kung Fu Panda%');
create or replace view aggJoin2532249612760801734 as (
with aggView2481355727320311514 as (select person_id as v48 from aka_name as an group by person_id)
select id as v48, name as v49, gender as v52 from name as n, aggView2481355727320311514 where n.id=aggView2481355727320311514.v48 and gender= 'f');
create or replace view aggJoin303487860817866660 as (
with aggView1735228859988653524 as (select v49, v48 from aggJoin2532249612760801734 group by v49,v48)
select v48, v49 from aggView1735228859988653524 where v49 LIKE '%An%');
create or replace view aggJoin1083736192966077566 as (
with aggView4259395703317912557 as (select v59, MIN(v60) as v73 from aggJoin455334898569907601 group by v59)
select person_id as v48, movie_id as v59, person_role_id as v9, note as v20, role_id as v57, v73 from cast_info as ci, aggView4259395703317912557 where ci.movie_id=aggView4259395703317912557.v59 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin5567546248517952386 as (
with aggView2177461767054743804 as (select v48, MIN(v49) as v72 from aggJoin303487860817866660 group by v48)
select v59, v9, v20, v57, v73 as v73, v72 from aggJoin1083736192966077566 join aggView2177461767054743804 using(v48));
create or replace view aggJoin7237582217469525046 as (
with aggView4958925910313735101 as (select id as v57 from role_type as rt where role= 'actress')
select v59, v9, v20, v73, v72 from aggJoin5567546248517952386 join aggView4958925910313735101 using(v57));
create or replace view aggJoin8202059426936086754 as (
with aggView8639067688040467061 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView8639067688040467061 where mi.info_type_id=aggView8639067688040467061.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin5343539621403670408 as (
with aggView2676185760096794040 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat','computer-animated-movie'))
select movie_id as v59 from movie_keyword as mk, aggView2676185760096794040 where mk.keyword_id=aggView2676185760096794040.v32);
create or replace view aggJoin4746277775327097597 as (
with aggView7313223094155571003 as (select v59 from aggJoin5343539621403670408 group by v59)
select v59, v9, v20, v73 as v73, v72 as v72 from aggJoin7237582217469525046 join aggView7313223094155571003 using(v59));
create or replace view aggJoin2787294137305856362 as (
with aggView2193626611111165518 as (select id as v23 from company_name as cn where country_code= '[us]' and name= 'DreamWorks Animation')
select movie_id as v59 from movie_companies as mc, aggView2193626611111165518 where mc.company_id=aggView2193626611111165518.v23);
create or replace view aggJoin3466465922572950523 as (
with aggView7659719938792391457 as (select v59 from aggJoin2787294137305856362 group by v59)
select v59, v9, v20, v73 as v73, v72 as v72 from aggJoin4746277775327097597 join aggView7659719938792391457 using(v59));
create or replace view aggJoin4308801815520361241 as (
with aggView4843277714096732633 as (select v59 from aggJoin8202059426936086754 group by v59)
select v9, v20, v73 as v73, v72 as v72 from aggJoin3466465922572950523 join aggView4843277714096732633 using(v59));
create or replace view aggJoin7529803502771024390 as (
with aggView7551041473471373747 as (select v9, MIN(v73) as v73, MIN(v72) as v72 from aggJoin4308801815520361241 group by v9,v72,v73)
select v10, v73, v72 from aggView3689517074779280171 join aggView7551041473471373747 using(v9));
select MIN(v10) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin7529803502771024390;
