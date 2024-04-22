create or replace view aggView6741927687998590224 as select name as v41, id as v40 from name as n where gender= 'm';
create or replace view aggView9160540834305740809 as select title as v50, id as v49 from title as t;
create or replace view aggJoin3713595007446340524 as (
with aggView4147242302898543453 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView4147242302898543453 where mi_idx.info_type_id=aggView4147242302898543453.v17);
create or replace view aggView8126492248066093438 as select v49, v35 from aggJoin3713595007446340524 group by v49,v35;
create or replace view aggJoin1487397932686584734 as (
with aggView7983133757800278297 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView7983133757800278297 where mk.keyword_id=aggView7983133757800278297.v19);
create or replace view aggJoin2326728502177917253 as (
with aggView5438650085892059649 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView5438650085892059649 where mi.info_type_id=aggView5438650085892059649.v15);
create or replace view aggJoin5989447469037276857 as (
with aggView8792871262915714087 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView8792871262915714087 where mc.company_id=aggView8792871262915714087.v8);
create or replace view aggJoin619029285187990363 as (
with aggView665840812144604341 as (select v49 from aggJoin5989447469037276857 group by v49)
select v49 from aggJoin1487397932686584734 join aggView665840812144604341 using(v49));
create or replace view aggJoin3985572618955003584 as (
with aggView6187500839654488234 as (select v49 from aggJoin619029285187990363 group by v49)
select v49, v30 from aggJoin2326728502177917253 join aggView6187500839654488234 using(v49));
create or replace view aggJoin5819022270644589870 as (
with aggView7420256315064460247 as (select v30, v49 from aggJoin3985572618955003584 group by v30,v49)
select v49, v30 from aggView7420256315064460247 where v30 IN ('Horror','Thriller'));
create or replace view aggJoin6456062727245105904 as (
with aggView8807310047841103777 as (select v49, MIN(v35) as v62 from aggView8126492248066093438 group by v49)
select person_id as v40, movie_id as v49, note as v5, v62 from cast_info as ci, aggView8807310047841103777 where ci.movie_id=aggView8807310047841103777.v49 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5734094435172234032 as (
with aggView3526096481808026849 as (select v49, MIN(v50) as v64 from aggView9160540834305740809 group by v49)
select v49, v30, v64 from aggJoin5819022270644589870 join aggView3526096481808026849 using(v49));
create or replace view aggJoin3213729091355663374 as (
with aggView8057029625077067299 as (select v49, MIN(v64) as v64, MIN(v30) as v61 from aggJoin5734094435172234032 group by v49,v64)
select v40, v5, v62 as v62, v64, v61 from aggJoin6456062727245105904 join aggView8057029625077067299 using(v49));
create or replace view aggJoin5070651045745000485 as (
with aggView7566237640037815713 as (select v40, MIN(v62) as v62, MIN(v64) as v64, MIN(v61) as v61 from aggJoin3213729091355663374 group by v40,v64,v61,v62)
select v41, v62, v64, v61 from aggView6741927687998590224 join aggView7566237640037815713 using(v40));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v41) as v63,MIN(v64) as v64 from aggJoin5070651045745000485;
