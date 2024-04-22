create or replace view aggView4353978934398893807 as select name as v37, id as v36 from name as n where gender= 'm';
create or replace view aggJoin6596267699309589834 as (
with aggView5289087063855940689 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView5289087063855940689 where cc.status_id=aggView5289087063855940689.v7);
create or replace view aggJoin7890589012250035634 as (
with aggView1542537905202048536 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView1542537905202048536 where mk.keyword_id=aggView1542537905202048536.v20);
create or replace view aggJoin2871576917762844270 as (
with aggView4322072329101113495 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView4322072329101113495 where mi.info_type_id=aggView4322072329101113495.v16 and info IN ('Horror','Thriller'));
create or replace view aggJoin2089976977079681140 as (
with aggView1349875250506701414 as (select v45 from aggJoin7890589012250035634 group by v45)
select v45, v26 from aggJoin2871576917762844270 join aggView1349875250506701414 using(v45));
create or replace view aggView877836853591596231 as select v26, v45 from aggJoin2089976977079681140 group by v26,v45;
create or replace view aggJoin7805808909950021580 as (
with aggView5930703022557422580 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v45 from aggJoin6596267699309589834 join aggView5930703022557422580 using(v5));
create or replace view aggJoin7627360152798691351 as (
with aggView7875646979516336359 as (select v45 from aggJoin7805808909950021580 group by v45)
select id as v45, title as v46, production_year as v49 from title as t, aggView7875646979516336359 where t.id=aggView7875646979516336359.v45 and ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000);
create or replace view aggView7642623748554830755 as select v46, v45 from aggJoin7627360152798691351 group by v46,v45;
create or replace view aggJoin6865452511838043992 as (
with aggView8838936650366401270 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView8838936650366401270 where mi_idx.info_type_id=aggView8838936650366401270.v18);
create or replace view aggView6130673187677059778 as select v31, v45 from aggJoin6865452511838043992 group by v31,v45;
create or replace view aggJoin5270069222328123122 as (
with aggView574236825220607153 as (select v45, MIN(v26) as v57 from aggView877836853591596231 group by v45)
select v31, v45, v57 from aggView6130673187677059778 join aggView574236825220607153 using(v45));
create or replace view aggJoin6046557045972305012 as (
with aggView278961091200085200 as (select v45, MIN(v57) as v57, MIN(v31) as v58 from aggJoin5270069222328123122 group by v45,v57)
select v46, v45, v57, v58 from aggView7642623748554830755 join aggView278961091200085200 using(v45));
create or replace view aggJoin7215125877343233495 as (
with aggView2739281732224337118 as (select v36, MIN(v37) as v59 from aggView4353978934398893807 group by v36)
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView2739281732224337118 where ci.person_id=aggView2739281732224337118.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin4163769114778199273 as (
with aggView5035719458185097882 as (select v45, MIN(v59) as v59 from aggJoin7215125877343233495 group by v45,v59)
select v46, v57 as v57, v58 as v58, v59 from aggJoin6046557045972305012 join aggView5035719458185097882 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v46) as v60 from aggJoin4163769114778199273;
