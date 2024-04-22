create or replace view aggJoin7219545862268596297 as (
with aggView5404117905605463561 as (select id as v49, title as v64 from title as t)
select movie_id as v49, info_type_id as v15, info as v30, v64 from movie_info as mi, aggView5404117905605463561 where mi.movie_id=aggView5404117905605463561.v49 and info IN ('Horror','Thriller'));
create or replace view aggJoin1501149063556696887 as (
with aggView3353904383289189062 as (select id as v40, name as v63 from name as n where gender= 'm')
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView3353904383289189062 where ci.person_id=aggView3353904383289189062.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin1670404587384384135 as (
with aggView1221296655261707661 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView1221296655261707661 where mi_idx.info_type_id=aggView1221296655261707661.v17);
create or replace view aggJoin3389763052612275777 as (
with aggView5491203333232609858 as (select v49, MIN(v35) as v62 from aggJoin1670404587384384135 group by v49)
select movie_id as v49, keyword_id as v19, v62 from movie_keyword as mk, aggView5491203333232609858 where mk.movie_id=aggView5491203333232609858.v49);
create or replace view aggJoin6015037897135774770 as (
with aggView3829374413909588637 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select v49, v62 from aggJoin3389763052612275777 join aggView3829374413909588637 using(v19));
create or replace view aggJoin852789792831522098 as (
with aggView1085391488346319241 as (select v49, MIN(v63) as v63 from aggJoin1501149063556696887 group by v49,v63)
select movie_id as v49, company_id as v8, v63 from movie_companies as mc, aggView1085391488346319241 where mc.movie_id=aggView1085391488346319241.v49);
create or replace view aggJoin6481808090994183921 as (
with aggView6777947452853830142 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select v49, v63 from aggJoin852789792831522098 join aggView6777947452853830142 using(v8));
create or replace view aggJoin7828811908645027003 as (
with aggView6078422041114743098 as (select id as v15 from info_type as it1 where info= 'genres')
select v49, v30, v64 from aggJoin7219545862268596297 join aggView6078422041114743098 using(v15));
create or replace view aggJoin5506110763742619886 as (
with aggView4155717123394764312 as (select v49, MIN(v63) as v63 from aggJoin6481808090994183921 group by v49,v63)
select v49, v30, v64 as v64, v63 from aggJoin7828811908645027003 join aggView4155717123394764312 using(v49));
create or replace view aggJoin2957046428470868661 as (
with aggView6417943951222642367 as (select v49, MIN(v64) as v64, MIN(v63) as v63, MIN(v30) as v61 from aggJoin5506110763742619886 group by v49,v64,v63)
select v62 as v62, v64, v63, v61 from aggJoin6015037897135774770 join aggView6417943951222642367 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v64) as v64 from aggJoin2957046428470868661;
