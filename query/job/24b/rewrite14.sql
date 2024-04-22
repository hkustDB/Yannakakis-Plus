create or replace view aggView3493904400101074381 as select id as v9, name as v10 from char_name as chn;
create or replace view aggView3613085529946859994 as select name as v49, id as v48 from name as n where name LIKE '%An%' and gender= 'f';
create or replace view aggJoin825929129118377112 as (
with aggView161108646967418932 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat','computer-animated-movie'))
select movie_id as v59 from movie_keyword as mk, aggView161108646967418932 where mk.keyword_id=aggView161108646967418932.v32);
create or replace view aggJoin1594530351013464239 as (
with aggView4170369377233979651 as (select v59 from aggJoin825929129118377112 group by v59)
select id as v59, title as v60, production_year as v63 from title as t, aggView4170369377233979651 where t.id=aggView4170369377233979651.v59 and production_year>2010);
create or replace view aggJoin624609948656125017 as (
with aggView1068186718144611088 as (select v59, v60 from aggJoin1594530351013464239 group by v59,v60)
select v59, v60 from aggView1068186718144611088 where v60 LIKE 'Kung Fu Panda%');
create or replace view aggJoin492727212771903351 as (
with aggView940245017810753614 as (select v59, MIN(v60) as v73 from aggJoin624609948656125017 group by v59)
select person_id as v48, movie_id as v59, person_role_id as v9, note as v20, role_id as v57, v73 from cast_info as ci, aggView940245017810753614 where ci.movie_id=aggView940245017810753614.v59 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin6644230295561636426 as (
with aggView7599020065357139769 as (select v9, MIN(v10) as v71 from aggView3493904400101074381 group by v9)
select v48, v59, v20, v57, v73 as v73, v71 from aggJoin492727212771903351 join aggView7599020065357139769 using(v9));
create or replace view aggJoin181114350258796943 as (
with aggView1095986790110099386 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v59, v20, v73, v71 from aggJoin6644230295561636426 join aggView1095986790110099386 using(v57));
create or replace view aggJoin7517007443385085912 as (
with aggView1625406079382463346 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView1625406079382463346 where mi.info_type_id=aggView1625406079382463346.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin7725032896392935702 as (
with aggView8322714791087503573 as (select person_id as v48 from aka_name as an group by person_id)
select v48, v59, v20, v73 as v73, v71 as v71 from aggJoin181114350258796943 join aggView8322714791087503573 using(v48));
create or replace view aggJoin4877948083997683316 as (
with aggView5054932031040869317 as (select v59 from aggJoin7517007443385085912 group by v59)
select movie_id as v59, company_id as v23 from movie_companies as mc, aggView5054932031040869317 where mc.movie_id=aggView5054932031040869317.v59);
create or replace view aggJoin2323583482202842417 as (
with aggView8805592513262011082 as (select id as v23 from company_name as cn where country_code= '[us]' and name= 'DreamWorks Animation')
select v59 from aggJoin4877948083997683316 join aggView8805592513262011082 using(v23));
create or replace view aggJoin568962244589796934 as (
with aggView3359724070494034937 as (select v59 from aggJoin2323583482202842417 group by v59)
select v48, v20, v73 as v73, v71 as v71 from aggJoin7725032896392935702 join aggView3359724070494034937 using(v59));
create or replace view aggJoin9129294505210054524 as (
with aggView7204679385776258610 as (select v48, MIN(v73) as v73, MIN(v71) as v71 from aggJoin568962244589796934 group by v48,v71,v73)
select v49, v73, v71 from aggView3613085529946859994 join aggView7204679385776258610 using(v48));
select MIN(v71) as v71,MIN(v49) as v72,MIN(v73) as v73 from aggJoin9129294505210054524;
