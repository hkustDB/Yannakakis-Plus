create or replace view aggView8977209122989684128 as select id as v45, title as v46 from title as t;
create or replace view aggView1503940267395608724 as select id as v36, name as v37 from name as n where gender= 'm';
create or replace view aggJoin785142604254198174 as (
with aggView7610945101412600107 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView7610945101412600107 where cc.status_id=aggView7610945101412600107.v7);
create or replace view aggJoin6764512889711049754 as (
with aggView466379401677176299 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView466379401677176299 where mi.info_type_id=aggView466379401677176299.v16);
create or replace view aggJoin7515190624238008275 as (
with aggView9142232834378485336 as (select v45, v26 from aggJoin6764512889711049754 group by v45,v26)
select v45, v26 from aggView9142232834378485336 where v26 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin1443379614927866567 as (
with aggView7068535815256329365 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45 from aggJoin785142604254198174 join aggView7068535815256329365 using(v5));
create or replace view aggJoin5090765101301849657 as (
with aggView6071501390889554560 as (select v45 from aggJoin1443379614927866567 group by v45)
select movie_id as v45, info_type_id as v18, info as v31 from movie_info_idx as mi_idx, aggView6071501390889554560 where mi_idx.movie_id=aggView6071501390889554560.v45);
create or replace view aggJoin4004009295725585396 as (
with aggView8749320175969094226 as (select id as v18 from info_type as it2 where info= 'votes')
select v45, v31 from aggJoin5090765101301849657 join aggView8749320175969094226 using(v18));
create or replace view aggView2069485201820621144 as select v45, v31 from aggJoin4004009295725585396 group by v45,v31;
create or replace view aggJoin7163649526561945006 as (
with aggView3715823188919654868 as (select v45, MIN(v26) as v57 from aggJoin7515190624238008275 group by v45)
select v45, v31, v57 from aggView2069485201820621144 join aggView3715823188919654868 using(v45));
create or replace view aggJoin5746944916005660526 as (
with aggView3406566527970530327 as (select v45, MIN(v46) as v60 from aggView8977209122989684128 group by v45)
select v45, v31, v57 as v57, v60 from aggJoin7163649526561945006 join aggView3406566527970530327 using(v45));
create or replace view aggJoin5801130149598417730 as (
with aggView5456821382160216218 as (select v36, MIN(v37) as v59 from aggView1503940267395608724 group by v36)
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView5456821382160216218 where ci.person_id=aggView5456821382160216218.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin128839842352515242 as (
with aggView3664832996090600213 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView3664832996090600213 where mk.keyword_id=aggView3664832996090600213.v20);
create or replace view aggJoin5912377149985642538 as (
with aggView3352754656398952826 as (select v45 from aggJoin128839842352515242 group by v45)
select v45, v13, v59 as v59 from aggJoin5801130149598417730 join aggView3352754656398952826 using(v45));
create or replace view aggJoin2360933436582155322 as (
with aggView1573903896819515592 as (select v45, MIN(v59) as v59 from aggJoin5912377149985642538 group by v45,v59)
select v31, v57 as v57, v60 as v60, v59 from aggJoin5746944916005660526 join aggView1573903896819515592 using(v45));
select MIN(v57) as v57,MIN(v31) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin2360933436582155322;
