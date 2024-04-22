create or replace view aggView627589766526120944 as select name as v37, id as v36 from name as n where gender= 'm';
create or replace view aggJoin412698297776494005 as (
with aggView6716129785239071058 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView6716129785239071058 where cc.status_id=aggView6716129785239071058.v7);
create or replace view aggJoin3587597529851482283 as (
with aggView1201220830798160173 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView1201220830798160173 where mk.keyword_id=aggView1201220830798160173.v20);
create or replace view aggJoin891857609638008377 as (
with aggView1329895385715138044 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView1329895385715138044 where mi.info_type_id=aggView1329895385715138044.v16);
create or replace view aggJoin4988260479158339370 as (
with aggView295220160808196730 as (select v26, v45 from aggJoin891857609638008377 group by v26,v45)
select v45, v26 from aggView295220160808196730 where v26 IN ('Horror','Thriller'));
create or replace view aggJoin5824113151413951711 as (
with aggView1536524380326729238 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v45 from aggJoin412698297776494005 join aggView1536524380326729238 using(v5));
create or replace view aggJoin4198250328369041535 as (
with aggView1526301455116047802 as (select v45 from aggJoin5824113151413951711 group by v45)
select id as v45, title as v46, production_year as v49 from title as t, aggView1526301455116047802 where t.id=aggView1526301455116047802.v45 and ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000);
create or replace view aggView3498320158510593415 as select v46, v45 from aggJoin4198250328369041535 group by v46,v45;
create or replace view aggJoin4813440999868360487 as (
with aggView899374468588574395 as (select v45 from aggJoin3587597529851482283 group by v45)
select movie_id as v45, info_type_id as v18, info as v31 from movie_info_idx as mi_idx, aggView899374468588574395 where mi_idx.movie_id=aggView899374468588574395.v45);
create or replace view aggJoin1915997794724016344 as (
with aggView1801455332631470931 as (select id as v18 from info_type as it2 where info= 'votes')
select v45, v31 from aggJoin4813440999868360487 join aggView1801455332631470931 using(v18));
create or replace view aggView7151823165645192082 as select v31, v45 from aggJoin1915997794724016344 group by v31,v45;
create or replace view aggJoin3408699721550882156 as (
with aggView2235205312129078248 as (select v45, MIN(v26) as v57 from aggJoin4988260479158339370 group by v45)
select v46, v45, v57 from aggView3498320158510593415 join aggView2235205312129078248 using(v45));
create or replace view aggJoin1161376671398251826 as (
with aggView1981215766756062308 as (select v36, MIN(v37) as v59 from aggView627589766526120944 group by v36)
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView1981215766756062308 where ci.person_id=aggView1981215766756062308.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin6891641525118984260 as (
with aggView7431114269024707323 as (select v45, MIN(v59) as v59 from aggJoin1161376671398251826 group by v45,v59)
select v46, v45, v57 as v57, v59 from aggJoin3408699721550882156 join aggView7431114269024707323 using(v45));
create or replace view aggJoin625577563623077500 as (
with aggView4017903187620986902 as (select v45, MIN(v57) as v57, MIN(v59) as v59, MIN(v46) as v60 from aggJoin6891641525118984260 group by v45,v59,v57)
select v31, v57, v59, v60 from aggView7151823165645192082 join aggView4017903187620986902 using(v45));
select MIN(v57) as v57,MIN(v31) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin625577563623077500;
