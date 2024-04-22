create or replace view aggView4969356355670429230 as select name as v41, id as v40 from name as n where gender= 'm';
create or replace view aggView226597713868813338 as select title as v50, id as v49 from title as t;
create or replace view aggJoin4515458720451372648 as (
with aggView6661683802889668911 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView6661683802889668911 where mi_idx.info_type_id=aggView6661683802889668911.v17);
create or replace view aggView8368250206707584098 as select v49, v35 from aggJoin4515458720451372648 group by v49,v35;
create or replace view aggJoin1507548908799485146 as (
with aggView1718141367822572418 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView1718141367822572418 where mi.info_type_id=aggView1718141367822572418.v15 and info IN ('Horror','Thriller'));
create or replace view aggView7234481111127044098 as select v30, v49 from aggJoin1507548908799485146 group by v30,v49;
create or replace view aggJoin9037488203434477399 as (
with aggView9056283114898629656 as (select v49, MIN(v35) as v62 from aggView8368250206707584098 group by v49)
select v50, v49, v62 from aggView226597713868813338 join aggView9056283114898629656 using(v49));
create or replace view aggJoin5321997128052056436 as (
with aggView4970504697687575183 as (select v49, MIN(v30) as v61 from aggView7234481111127044098 group by v49)
select person_id as v40, movie_id as v49, note as v5, v61 from cast_info as ci, aggView4970504697687575183 where ci.movie_id=aggView4970504697687575183.v49 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin1107324920572158782 as (
with aggView8741005983270150011 as (select v40, MIN(v41) as v63 from aggView4969356355670429230 group by v40)
select v49, v5, v61 as v61, v63 from aggJoin5321997128052056436 join aggView8741005983270150011 using(v40));
create or replace view aggJoin5511210033043595798 as (
with aggView6582887650756187577 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView6582887650756187577 where mk.keyword_id=aggView6582887650756187577.v19);
create or replace view aggJoin3225655656072596059 as (
with aggView7441957965366390823 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView7441957965366390823 where mc.company_id=aggView7441957965366390823.v8);
create or replace view aggJoin8219131020687873293 as (
with aggView630432901699758339 as (select v49 from aggJoin3225655656072596059 group by v49)
select v49, v5, v61 as v61, v63 as v63 from aggJoin1107324920572158782 join aggView630432901699758339 using(v49));
create or replace view aggJoin4534258403533813465 as (
with aggView2827685055931588934 as (select v49 from aggJoin5511210033043595798 group by v49)
select v49, v5, v61 as v61, v63 as v63 from aggJoin8219131020687873293 join aggView2827685055931588934 using(v49));
create or replace view aggJoin144503636679099505 as (
with aggView3272947441325043636 as (select v49, MIN(v61) as v61, MIN(v63) as v63 from aggJoin4534258403533813465 group by v49,v61,v63)
select v50, v62 as v62, v61, v63 from aggJoin9037488203434477399 join aggView3272947441325043636 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v50) as v64 from aggJoin144503636679099505;
