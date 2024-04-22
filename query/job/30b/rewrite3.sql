create or replace view aggView4820056103683646316 as select name as v37, id as v36 from name as n where gender= 'm';
create or replace view aggView5072068162170444779 as select title as v46, id as v45 from title as t where ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000;
create or replace view aggJoin1133933407815262936 as (
with aggView7628738689832079280 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView7628738689832079280 where mk.keyword_id=aggView7628738689832079280.v20);
create or replace view aggJoin2570513502903686529 as (
with aggView6179451932369812409 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView6179451932369812409 where mi.info_type_id=aggView6179451932369812409.v16);
create or replace view aggJoin8797707701443708437 as (
with aggView5135042546281805653 as (select v45 from aggJoin1133933407815262936 group by v45)
select v45, v26 from aggJoin2570513502903686529 join aggView5135042546281805653 using(v45));
create or replace view aggJoin8295173672941653826 as (
with aggView437840526992222643 as (select v26, v45 from aggJoin8797707701443708437 group by v26,v45)
select v45, v26 from aggView437840526992222643 where v26 IN ('Horror','Thriller'));
create or replace view aggJoin9173516868663454522 as (
with aggView5250389702290447312 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView5250389702290447312 where mi_idx.info_type_id=aggView5250389702290447312.v18);
create or replace view aggView9027714315307533242 as select v31, v45 from aggJoin9173516868663454522 group by v31,v45;
create or replace view aggJoin3240367670879197094 as (
with aggView8906271162501494731 as (select v45, MIN(v31) as v58 from aggView9027714315307533242 group by v45)
select person_id as v36, movie_id as v45, note as v13, v58 from cast_info as ci, aggView8906271162501494731 where ci.movie_id=aggView8906271162501494731.v45 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin1064674331859927296 as (
with aggView3746362240131606620 as (select v36, MIN(v37) as v59 from aggView4820056103683646316 group by v36)
select v45, v13, v58 as v58, v59 from aggJoin3240367670879197094 join aggView3746362240131606620 using(v36));
create or replace view aggJoin1401678779642148577 as (
with aggView4651806790302459703 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView4651806790302459703 where cc.status_id=aggView4651806790302459703.v7);
create or replace view aggJoin5574362820848357407 as (
with aggView811655022990981182 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v45 from aggJoin1401678779642148577 join aggView811655022990981182 using(v5));
create or replace view aggJoin6496495206735049595 as (
with aggView379516885719402141 as (select v45 from aggJoin5574362820848357407 group by v45)
select v45, v13, v58 as v58, v59 as v59 from aggJoin1064674331859927296 join aggView379516885719402141 using(v45));
create or replace view aggJoin7417221156567261616 as (
with aggView8781955234003046992 as (select v45, MIN(v58) as v58, MIN(v59) as v59 from aggJoin6496495206735049595 group by v45,v58,v59)
select v46, v45, v58, v59 from aggView5072068162170444779 join aggView8781955234003046992 using(v45));
create or replace view aggJoin2508988413403222804 as (
with aggView810007835916360904 as (select v45, MIN(v58) as v58, MIN(v59) as v59, MIN(v46) as v60 from aggJoin7417221156567261616 group by v45,v58,v59)
select v26, v58, v59, v60 from aggJoin8295173672941653826 join aggView810007835916360904 using(v45));
select MIN(v26) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin2508988413403222804;
