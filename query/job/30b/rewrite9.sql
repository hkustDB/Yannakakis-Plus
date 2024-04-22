create or replace view aggJoin7110093880667065506 as (
with aggView7208534954247374301 as (select id as v36, name as v59 from name as n where gender= 'm')
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView7208534954247374301 where ci.person_id=aggView7208534954247374301.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3332319499403681210 as (
with aggView6767689531406070077 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView6767689531406070077 where cc.status_id=aggView6767689531406070077.v7);
create or replace view aggJoin8900900348046352879 as (
with aggView641079044674098401 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView641079044674098401 where mk.keyword_id=aggView641079044674098401.v20);
create or replace view aggJoin5434347115009971018 as (
with aggView7448149491958081406 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView7448149491958081406 where mi.info_type_id=aggView7448149491958081406.v16 and info IN ('Horror','Thriller'));
create or replace view aggJoin123157765224146835 as (
with aggView2190326364920543259 as (select v45, MIN(v26) as v57 from aggJoin5434347115009971018 group by v45)
select movie_id as v45, info_type_id as v18, info as v31, v57 from movie_info_idx as mi_idx, aggView2190326364920543259 where mi_idx.movie_id=aggView2190326364920543259.v45);
create or replace view aggJoin2383896078175506932 as (
with aggView559753633325623012 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v45 from aggJoin3332319499403681210 join aggView559753633325623012 using(v5));
create or replace view aggJoin9189960074492885645 as (
with aggView6021191723660764429 as (select v45 from aggJoin2383896078175506932 group by v45)
select v45, v13, v59 as v59 from aggJoin7110093880667065506 join aggView6021191723660764429 using(v45));
create or replace view aggJoin1337863697329446640 as (
with aggView2719829485311462720 as (select v45, MIN(v59) as v59 from aggJoin9189960074492885645 group by v45,v59)
select id as v45, title as v46, production_year as v49, v59 from title as t, aggView2719829485311462720 where t.id=aggView2719829485311462720.v45 and ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000);
create or replace view aggJoin8024641022895793287 as (
with aggView8508171268509799719 as (select v45, MIN(v59) as v59, MIN(v46) as v60 from aggJoin1337863697329446640 group by v45,v59)
select v45, v18, v31, v57 as v57, v59, v60 from aggJoin123157765224146835 join aggView8508171268509799719 using(v45));
create or replace view aggJoin5232333724196045479 as (
with aggView1969844105816661344 as (select id as v18 from info_type as it2 where info= 'votes')
select v45, v31, v57, v59, v60 from aggJoin8024641022895793287 join aggView1969844105816661344 using(v18));
create or replace view aggJoin6090625818637753516 as (
with aggView575916994517158112 as (select v45, MIN(v57) as v57, MIN(v59) as v59, MIN(v60) as v60, MIN(v31) as v58 from aggJoin5232333724196045479 group by v45,v59,v60,v57)
select v57, v59, v60, v58 from aggJoin8900900348046352879 join aggView575916994517158112 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin6090625818637753516;
