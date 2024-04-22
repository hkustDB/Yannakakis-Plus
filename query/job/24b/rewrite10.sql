create or replace view aggJoin7302739403565801282 as (
with aggView5819125269363212100 as (select id as v9, name as v71 from char_name as chn)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView5819125269363212100 where ci.person_role_id=aggView5819125269363212100.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4073938362926342537 as (
with aggView3000867442346815606 as (select id as v59, title as v73 from title as t where title LIKE 'Kung Fu Panda%' and production_year>2010)
select movie_id as v59, company_id as v23, v73 from movie_companies as mc, aggView3000867442346815606 where mc.movie_id=aggView3000867442346815606.v59);
create or replace view aggJoin2181476169784479427 as (
with aggView5162639145452479765 as (select id as v48, name as v72 from name as n where name LIKE '%An%' and gender= 'f')
select person_id as v48, v72 from aka_name as an, aggView5162639145452479765 where an.person_id=aggView5162639145452479765.v48);
create or replace view aggJoin4653491423410480482 as (
with aggView3178149750164962295 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v59, v20, v71 from aggJoin7302739403565801282 join aggView3178149750164962295 using(v57));
create or replace view aggJoin3862774899048344428 as (
with aggView805497862093523714 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView805497862093523714 where mi.info_type_id=aggView805497862093523714.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin5865274149548601037 as (
with aggView5851193673688600838 as (select v48, MIN(v72) as v72 from aggJoin2181476169784479427 group by v48,v72)
select v59, v20, v71 as v71, v72 from aggJoin4653491423410480482 join aggView5851193673688600838 using(v48));
create or replace view aggJoin46041191298404068 as (
with aggView477497052753726704 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat','computer-animated-movie'))
select movie_id as v59 from movie_keyword as mk, aggView477497052753726704 where mk.keyword_id=aggView477497052753726704.v32);
create or replace view aggJoin5978377674062479575 as (
with aggView5095417367563991084 as (select v59 from aggJoin3862774899048344428 group by v59)
select v59, v23, v73 as v73 from aggJoin4073938362926342537 join aggView5095417367563991084 using(v59));
create or replace view aggJoin5068444407197476173 as (
with aggView6903999795136640027 as (select id as v23 from company_name as cn where country_code= '[us]' and name= 'DreamWorks Animation')
select v59, v73 from aggJoin5978377674062479575 join aggView6903999795136640027 using(v23));
create or replace view aggJoin4409707841906370985 as (
with aggView628377361178552395 as (select v59, MIN(v73) as v73 from aggJoin5068444407197476173 group by v59,v73)
select v59, v20, v71 as v71, v72 as v72, v73 from aggJoin5865274149548601037 join aggView628377361178552395 using(v59));
create or replace view aggJoin8435332883518060627 as (
with aggView7100247228869027596 as (select v59, MIN(v71) as v71, MIN(v72) as v72, MIN(v73) as v73 from aggJoin4409707841906370985 group by v59,v72,v71,v73)
select v71, v72, v73 from aggJoin46041191298404068 join aggView7100247228869027596 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin8435332883518060627;
