create or replace view aggView2013264696677720631 as select name as v37, id as v36 from name as n where gender= 'm';
create or replace view aggView1683071376664534331 as select title as v46, id as v45 from title as t where ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000;
create or replace view aggJoin3790673177814409273 as (
with aggView5834635150643485054 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView5834635150643485054 where cc.status_id=aggView5834635150643485054.v7);
create or replace view aggJoin2017421742049020296 as (
with aggView2775313577064764740 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView2775313577064764740 where mk.keyword_id=aggView2775313577064764740.v20);
create or replace view aggJoin6924395753011290674 as (
with aggView7169076145996612795 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView7169076145996612795 where mi.info_type_id=aggView7169076145996612795.v16);
create or replace view aggJoin778933546054576622 as (
with aggView9152865837041408144 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v45 from aggJoin3790673177814409273 join aggView9152865837041408144 using(v5));
create or replace view aggJoin523226082283950153 as (
with aggView5255796933473700843 as (select v45 from aggJoin2017421742049020296 group by v45)
select v45 from aggJoin778933546054576622 join aggView5255796933473700843 using(v45));
create or replace view aggJoin6543442987658412248 as (
with aggView2074324962631566301 as (select v45 from aggJoin523226082283950153 group by v45)
select v45, v26 from aggJoin6924395753011290674 join aggView2074324962631566301 using(v45));
create or replace view aggJoin6694720006728997068 as (
with aggView388810918988288116 as (select v26, v45 from aggJoin6543442987658412248 group by v26,v45)
select v45, v26 from aggView388810918988288116 where v26 IN ('Horror','Thriller'));
create or replace view aggJoin2997032997971910471 as (
with aggView1721716553223859567 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView1721716553223859567 where mi_idx.info_type_id=aggView1721716553223859567.v18);
create or replace view aggView2484562723794723759 as select v31, v45 from aggJoin2997032997971910471 group by v31,v45;
create or replace view aggJoin7194889243515390679 as (
with aggView8507683968775550340 as (select v36, MIN(v37) as v59 from aggView2013264696677720631 group by v36)
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView8507683968775550340 where ci.person_id=aggView8507683968775550340.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8349526994804859179 as (
with aggView7908836375646343511 as (select v45, MIN(v31) as v58 from aggView2484562723794723759 group by v45)
select v46, v45, v58 from aggView1683071376664534331 join aggView7908836375646343511 using(v45));
create or replace view aggJoin5620701472610185223 as (
with aggView3645528500078394671 as (select v45, MIN(v59) as v59 from aggJoin7194889243515390679 group by v45,v59)
select v45, v26, v59 from aggJoin6694720006728997068 join aggView3645528500078394671 using(v45));
create or replace view aggJoin8257735168295390738 as (
with aggView6670917684069383437 as (select v45, MIN(v59) as v59, MIN(v26) as v57 from aggJoin5620701472610185223 group by v45,v59)
select v46, v58 as v58, v59, v57 from aggJoin8349526994804859179 join aggView6670917684069383437 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v46) as v60 from aggJoin8257735168295390738;
