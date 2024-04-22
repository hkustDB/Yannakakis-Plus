create or replace view aggJoin4806978593093485376 as (
with aggView5973462426394969463 as (select id as v36, name as v59 from name as n where gender= 'm')
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView5973462426394969463 where ci.person_id=aggView5973462426394969463.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5813850808321917236 as (
with aggView2757828423426185968 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView2757828423426185968 where cc.status_id=aggView2757828423426185968.v7);
create or replace view aggJoin2182472756980483600 as (
with aggView6395490637879357436 as (select v45, MIN(v59) as v59 from aggJoin4806978593093485376 group by v45,v59)
select id as v45, title as v46, production_year as v49, v59 from title as t, aggView6395490637879357436 where t.id=aggView6395490637879357436.v45 and ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000);
create or replace view aggJoin3501810234815868041 as (
with aggView2203430961623362521 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView2203430961623362521 where mk.keyword_id=aggView2203430961623362521.v20);
create or replace view aggJoin2552983652955643938 as (
with aggView5183630561874341220 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView5183630561874341220 where mi.info_type_id=aggView5183630561874341220.v16 and info IN ('Horror','Thriller'));
create or replace view aggJoin5021432387678085676 as (
with aggView5512589339793012609 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v45 from aggJoin5813850808321917236 join aggView5512589339793012609 using(v5));
create or replace view aggJoin3958444373882956090 as (
with aggView1542839031332179628 as (select v45 from aggJoin5021432387678085676 group by v45)
select v45, v46, v49, v59 as v59 from aggJoin2182472756980483600 join aggView1542839031332179628 using(v45));
create or replace view aggJoin1910213029253275131 as (
with aggView4320484655423568547 as (select v45, MIN(v59) as v59, MIN(v46) as v60 from aggJoin3958444373882956090 group by v45,v59)
select v45, v26, v59, v60 from aggJoin2552983652955643938 join aggView4320484655423568547 using(v45));
create or replace view aggJoin7732079343260106243 as (
with aggView4548738216367482811 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView4548738216367482811 where mi_idx.info_type_id=aggView4548738216367482811.v18);
create or replace view aggJoin3277935065230201353 as (
with aggView7402132034938078620 as (select v45, MIN(v31) as v58 from aggJoin7732079343260106243 group by v45)
select v45, v26, v59 as v59, v60 as v60, v58 from aggJoin1910213029253275131 join aggView7402132034938078620 using(v45));
create or replace view aggJoin1821143106939820140 as (
with aggView3929347048093290354 as (select v45, MIN(v59) as v59, MIN(v60) as v60, MIN(v58) as v58, MIN(v26) as v57 from aggJoin3277935065230201353 group by v45,v58,v59,v60)
select v59, v60, v58, v57 from aggJoin3501810234815868041 join aggView3929347048093290354 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin1821143106939820140;
