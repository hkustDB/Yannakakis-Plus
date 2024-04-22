create or replace view aggJoin5233472094590292562 as (
with aggView4956461060423817968 as (select id as v9, name as v71 from char_name as chn)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView4956461060423817968 where ci.person_role_id=aggView4956461060423817968.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin3981279565530286657 as (
with aggView1531119113417517633 as (select id as v48, name as v72 from name as n where name LIKE '%An%' and gender= 'f')
select v48, v59, v20, v57, v71, v72 from aggJoin5233472094590292562 join aggView1531119113417517633 using(v48));
create or replace view aggJoin3783402465458210860 as (
with aggView225119633661938771 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView225119633661938771 where mi.info_type_id=aggView225119633661938771.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin4685947416976589696 as (
with aggView572184879856801769 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v59 from movie_companies as mc, aggView572184879856801769 where mc.company_id=aggView572184879856801769.v23);
create or replace view aggJoin2957622459731717415 as (
with aggView7405967434672715384 as (select person_id as v48 from aka_name as an group by person_id)
select v59, v20, v57, v71 as v71, v72 as v72 from aggJoin3981279565530286657 join aggView7405967434672715384 using(v48));
create or replace view aggJoin8727288673035307991 as (
with aggView7853840153001663785 as (select v59 from aggJoin4685947416976589696 group by v59)
select v59, v43 from aggJoin3783402465458210860 join aggView7853840153001663785 using(v59));
create or replace view aggJoin3518494993731942463 as (
with aggView5845443678105955044 as (select id as v57 from role_type as rt where role= 'actress')
select v59, v20, v71, v72 from aggJoin2957622459731717415 join aggView5845443678105955044 using(v57));
create or replace view aggJoin9160447609905287903 as (
with aggView5044491456522752295 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat'))
select movie_id as v59 from movie_keyword as mk, aggView5044491456522752295 where mk.keyword_id=aggView5044491456522752295.v32);
create or replace view aggJoin7390582018661606526 as (
with aggView3089647418456004002 as (select v59 from aggJoin9160447609905287903 group by v59)
select v59, v20, v71 as v71, v72 as v72 from aggJoin3518494993731942463 join aggView3089647418456004002 using(v59));
create or replace view aggJoin6382565681781260314 as (
with aggView2372149025582066202 as (select v59, MIN(v71) as v71, MIN(v72) as v72 from aggJoin7390582018661606526 group by v59,v72,v71)
select id as v59, title as v60, production_year as v63, v71, v72 from title as t, aggView2372149025582066202 where t.id=aggView2372149025582066202.v59 and production_year>2010);
create or replace view aggJoin3324725159999519141 as (
with aggView8046841455521930464 as (select v59, MIN(v71) as v71, MIN(v72) as v72, MIN(v60) as v73 from aggJoin6382565681781260314 group by v59,v72,v71)
select v71, v72, v73 from aggJoin8727288673035307991 join aggView8046841455521930464 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin3324725159999519141;
