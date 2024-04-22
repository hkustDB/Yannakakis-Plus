create or replace view aggView2317304199906872715 as select name as v37, id as v36 from name as n where gender= 'm';
create or replace view aggView6959043983680980413 as select title as v46, id as v45 from title as t where ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000;
create or replace view aggJoin6231731534280406420 as (
with aggView955697842243447604 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView955697842243447604 where cc.status_id=aggView955697842243447604.v7);
create or replace view aggJoin5844268027774411683 as (
with aggView8362993847121363469 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView8362993847121363469 where mi.info_type_id=aggView8362993847121363469.v16 and info IN ('Horror','Thriller'));
create or replace view aggJoin6794739305803034503 as (
with aggView2457779681196545051 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v45 from aggJoin6231731534280406420 join aggView2457779681196545051 using(v5));
create or replace view aggJoin5482855145693727298 as (
with aggView6175318246930714542 as (select v45 from aggJoin6794739305803034503 group by v45)
select v45, v26 from aggJoin5844268027774411683 join aggView6175318246930714542 using(v45));
create or replace view aggView8693671558906414468 as select v26, v45 from aggJoin5482855145693727298 group by v26,v45;
create or replace view aggJoin5385489643611975304 as (
with aggView2625857270756713275 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView2625857270756713275 where mi_idx.info_type_id=aggView2625857270756713275.v18);
create or replace view aggView7235059331043731937 as select v31, v45 from aggJoin5385489643611975304 group by v31,v45;
create or replace view aggJoin6197938613869583805 as (
with aggView2829884929012660824 as (select v45, MIN(v46) as v60 from aggView6959043983680980413 group by v45)
select v26, v45, v60 from aggView8693671558906414468 join aggView2829884929012660824 using(v45));
create or replace view aggJoin4861258520081006378 as (
with aggView5278887064155589419 as (select v45, MIN(v60) as v60, MIN(v26) as v57 from aggJoin6197938613869583805 group by v45,v60)
select person_id as v36, movie_id as v45, note as v13, v60, v57 from cast_info as ci, aggView5278887064155589419 where ci.movie_id=aggView5278887064155589419.v45 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8718431552743550196 as (
with aggView6408565634826550284 as (select v45, MIN(v31) as v58 from aggView7235059331043731937 group by v45)
select v36, v45, v13, v60 as v60, v57 as v57, v58 from aggJoin4861258520081006378 join aggView6408565634826550284 using(v45));
create or replace view aggJoin9161368700305578721 as (
with aggView2366319043920615950 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView2366319043920615950 where mk.keyword_id=aggView2366319043920615950.v20);
create or replace view aggJoin8666760600295070366 as (
with aggView3224068456229337001 as (select v45 from aggJoin9161368700305578721 group by v45)
select v36, v13, v60 as v60, v57 as v57, v58 as v58 from aggJoin8718431552743550196 join aggView3224068456229337001 using(v45));
create or replace view aggJoin781022919540152814 as (
with aggView4185112913676202787 as (select v36, MIN(v60) as v60, MIN(v57) as v57, MIN(v58) as v58 from aggJoin8666760600295070366 group by v36,v58,v60,v57)
select v37, v60, v57, v58 from aggView2317304199906872715 join aggView4185112913676202787 using(v36));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v37) as v59,MIN(v60) as v60 from aggJoin781022919540152814;
