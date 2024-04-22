create or replace view aggView6597902030053328793 as select id as v45, title as v46 from title as t;
create or replace view aggView4245147042842284925 as select id as v36, name as v37 from name as n where gender= 'm';
create or replace view aggJoin3683130952466090651 as (
with aggView6771189362201067510 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView6771189362201067510 where mk.keyword_id=aggView6771189362201067510.v20);
create or replace view aggJoin3734160733468862389 as (
with aggView4252993578146827653 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView4252993578146827653 where mi.info_type_id=aggView4252993578146827653.v16 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin7103135435155382087 as (
with aggView2174340649434825794 as (select v45 from aggJoin3683130952466090651 group by v45)
select v45, v26 from aggJoin3734160733468862389 join aggView2174340649434825794 using(v45));
create or replace view aggView5343244501947571725 as select v45, v26 from aggJoin7103135435155382087 group by v45,v26;
create or replace view aggJoin7456027397535466401 as (
with aggView3634843655950019930 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView3634843655950019930 where mi_idx.info_type_id=aggView3634843655950019930.v18);
create or replace view aggView918480152918743458 as select v45, v31 from aggJoin7456027397535466401 group by v45,v31;
create or replace view aggJoin2612240813261603208 as (
with aggView7508409103755746688 as (select v36, MIN(v37) as v59 from aggView4245147042842284925 group by v36)
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView7508409103755746688 where ci.person_id=aggView7508409103755746688.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8624448307782026998 as (
with aggView7985420448034554174 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView7985420448034554174 where cc.status_id=aggView7985420448034554174.v7);
create or replace view aggJoin5692287789911131457 as (
with aggView3642942447100351691 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45 from aggJoin8624448307782026998 join aggView3642942447100351691 using(v5));
create or replace view aggJoin6016844684771991974 as (
with aggView6629084488948023697 as (select v45 from aggJoin5692287789911131457 group by v45)
select v45, v13, v59 as v59 from aggJoin2612240813261603208 join aggView6629084488948023697 using(v45));
create or replace view aggJoin5479105230048853976 as (
with aggView8286234509576921163 as (select v45, MIN(v59) as v59 from aggJoin6016844684771991974 group by v45,v59)
select v45, v46, v59 from aggView6597902030053328793 join aggView8286234509576921163 using(v45));
create or replace view aggJoin7636104246517175578 as (
with aggView9155927478016495516 as (select v45, MIN(v59) as v59, MIN(v46) as v60 from aggJoin5479105230048853976 group by v45,v59)
select v45, v31, v59, v60 from aggView918480152918743458 join aggView9155927478016495516 using(v45));
create or replace view aggJoin1995461666764944223 as (
with aggView3659874461212450228 as (select v45, MIN(v59) as v59, MIN(v60) as v60, MIN(v31) as v58 from aggJoin7636104246517175578 group by v45,v59,v60)
select v26, v59, v60, v58 from aggView5343244501947571725 join aggView3659874461212450228 using(v45));
select MIN(v26) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin1995461666764944223;
