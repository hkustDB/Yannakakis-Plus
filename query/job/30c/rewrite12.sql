create or replace view aggJoin1675287733009819132 as (
with aggView6581178071554599187 as (select id as v36, name as v59 from name as n where gender= 'm')
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView6581178071554599187 where ci.person_id=aggView6581178071554599187.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin7403886693322836087 as (
with aggView689575175830162128 as (select id as v45, title as v60 from title as t)
select movie_id as v45, keyword_id as v20, v60 from movie_keyword as mk, aggView689575175830162128 where mk.movie_id=aggView689575175830162128.v45);
create or replace view aggJoin6145985714971540392 as (
with aggView1768684260410302704 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select v45, v60 from aggJoin7403886693322836087 join aggView1768684260410302704 using(v20));
create or replace view aggJoin6437490954803489553 as (
with aggView2379634328870899032 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView2379634328870899032 where cc.status_id=aggView2379634328870899032.v7);
create or replace view aggJoin115723373334246680 as (
with aggView7533197563833516177 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView7533197563833516177 where mi.info_type_id=aggView7533197563833516177.v16 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin6834578604369299 as (
with aggView9038198774026696857 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45 from aggJoin6437490954803489553 join aggView9038198774026696857 using(v5));
create or replace view aggJoin1161612859710330815 as (
with aggView5913846706670119338 as (select v45 from aggJoin6834578604369299 group by v45)
select v45, v13, v59 as v59 from aggJoin1675287733009819132 join aggView5913846706670119338 using(v45));
create or replace view aggJoin2801380207907164470 as (
with aggView7089134456647077967 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView7089134456647077967 where mi_idx.info_type_id=aggView7089134456647077967.v18);
create or replace view aggJoin6796395878365628248 as (
with aggView4776693940339655474 as (select v45, MIN(v31) as v58 from aggJoin2801380207907164470 group by v45)
select v45, v26, v58 from aggJoin115723373334246680 join aggView4776693940339655474 using(v45));
create or replace view aggJoin6483001480210951141 as (
with aggView4714608592752921252 as (select v45, MIN(v58) as v58, MIN(v26) as v57 from aggJoin6796395878365628248 group by v45,v58)
select v45, v13, v59 as v59, v58, v57 from aggJoin1161612859710330815 join aggView4714608592752921252 using(v45));
create or replace view aggJoin710216660546065569 as (
with aggView7510803490267509284 as (select v45, MIN(v59) as v59, MIN(v58) as v58, MIN(v57) as v57 from aggJoin6483001480210951141 group by v45,v59,v57,v58)
select v60 as v60, v59, v58, v57 from aggJoin6145985714971540392 join aggView7510803490267509284 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin710216660546065569;
