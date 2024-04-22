create or replace view aggJoin4039100068877826561 as (
with aggView751036422721509536 as (select id as v40, name as v63 from name as n where gender= 'm')
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView751036422721509536 where ci.person_id=aggView751036422721509536.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3941850402265761034 as (
with aggView658415788030835794 as (select id as v49, title as v64 from title as t)
select movie_id as v49, company_id as v8, v64 from movie_companies as mc, aggView658415788030835794 where mc.movie_id=aggView658415788030835794.v49);
create or replace view aggJoin8561336582213073504 as (
with aggView5947764323599531612 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView5947764323599531612 where mi_idx.info_type_id=aggView5947764323599531612.v17);
create or replace view aggJoin4853980375843862646 as (
with aggView1652932515885164876 as (select v49, MIN(v35) as v62 from aggJoin8561336582213073504 group by v49)
select movie_id as v49, info_type_id as v15, info as v30, v62 from movie_info as mi, aggView1652932515885164876 where mi.movie_id=aggView1652932515885164876.v49 and info IN ('Horror','Thriller'));
create or replace view aggJoin2652701937376022324 as (
with aggView8828933444234604803 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView8828933444234604803 where mk.keyword_id=aggView8828933444234604803.v19);
create or replace view aggJoin6103027817927732035 as (
with aggView325668761595002788 as (select id as v15 from info_type as it1 where info= 'genres')
select v49, v30, v62 from aggJoin4853980375843862646 join aggView325668761595002788 using(v15));
create or replace view aggJoin7494269975368001081 as (
with aggView4651669648667996728 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select v49, v64 from aggJoin3941850402265761034 join aggView4651669648667996728 using(v8));
create or replace view aggJoin3643909012233047450 as (
with aggView687022130911421968 as (select v49, MIN(v64) as v64 from aggJoin7494269975368001081 group by v49,v64)
select v49, v30, v62 as v62, v64 from aggJoin6103027817927732035 join aggView687022130911421968 using(v49));
create or replace view aggJoin9015918501179447870 as (
with aggView7417734422299298944 as (select v49, MIN(v62) as v62, MIN(v64) as v64, MIN(v30) as v61 from aggJoin3643909012233047450 group by v49,v64,v62)
select v49, v5, v63 as v63, v62, v64, v61 from aggJoin4039100068877826561 join aggView7417734422299298944 using(v49));
create or replace view aggJoin1942292366509729577 as (
with aggView3586008297402985297 as (select v49, MIN(v63) as v63, MIN(v62) as v62, MIN(v64) as v64, MIN(v61) as v61 from aggJoin9015918501179447870 group by v49,v64,v61,v63,v62)
select v63, v62, v64, v61 from aggJoin2652701937376022324 join aggView3586008297402985297 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v64) as v64 from aggJoin1942292366509729577;
