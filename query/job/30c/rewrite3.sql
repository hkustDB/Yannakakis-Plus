create or replace view aggView2450199206552152641 as select id as v36, name as v37 from name as n where gender= 'm';
create or replace view aggJoin3654556516226916971 as (
with aggView9042566093769416914 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView9042566093769416914 where mk.keyword_id=aggView9042566093769416914.v20);
create or replace view aggJoin8437992821375840733 as (
with aggView4684722995770620020 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView4684722995770620020 where cc.status_id=aggView4684722995770620020.v7);
create or replace view aggJoin1414343403184042799 as (
with aggView5367073547168795659 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView5367073547168795659 where mi.info_type_id=aggView5367073547168795659.v16 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggView6942163416975397821 as select v45, v26 from aggJoin1414343403184042799 group by v45,v26;
create or replace view aggJoin815970384262528266 as (
with aggView7904045910368853779 as (select v45 from aggJoin3654556516226916971 group by v45)
select v45, v5 from aggJoin8437992821375840733 join aggView7904045910368853779 using(v45));
create or replace view aggJoin6876176827460235224 as (
with aggView5081693795387112450 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45 from aggJoin815970384262528266 join aggView5081693795387112450 using(v5));
create or replace view aggJoin8575561181885913033 as (
with aggView4977109229339697992 as (select v45 from aggJoin6876176827460235224 group by v45)
select id as v45, title as v46 from title as t, aggView4977109229339697992 where t.id=aggView4977109229339697992.v45);
create or replace view aggView1086087004322645249 as select v45, v46 from aggJoin8575561181885913033 group by v45,v46;
create or replace view aggJoin6787276477719938714 as (
with aggView4377222892587903553 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView4377222892587903553 where mi_idx.info_type_id=aggView4377222892587903553.v18);
create or replace view aggView4218369194725809812 as select v45, v31 from aggJoin6787276477719938714 group by v45,v31;
create or replace view aggJoin2325904433094019156 as (
with aggView5261631726488881935 as (select v45, MIN(v26) as v57 from aggView6942163416975397821 group by v45)
select v45, v31, v57 from aggView4218369194725809812 join aggView5261631726488881935 using(v45));
create or replace view aggJoin7692028900181373465 as (
with aggView7335778121764714242 as (select v45, MIN(v57) as v57, MIN(v31) as v58 from aggJoin2325904433094019156 group by v45,v57)
select v45, v46, v57, v58 from aggView1086087004322645249 join aggView7335778121764714242 using(v45));
create or replace view aggJoin6663308183359669804 as (
with aggView4729835602622020147 as (select v45, MIN(v57) as v57, MIN(v58) as v58, MIN(v46) as v60 from aggJoin7692028900181373465 group by v45,v57,v58)
select person_id as v36, note as v13, v57, v58, v60 from cast_info as ci, aggView4729835602622020147 where ci.movie_id=aggView4729835602622020147.v45 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin4221116521748696369 as (
with aggView2253871536726165878 as (select v36, MIN(v57) as v57, MIN(v58) as v58, MIN(v60) as v60 from aggJoin6663308183359669804 group by v36,v57,v60,v58)
select v37, v57, v58, v60 from aggView2450199206552152641 join aggView2253871536726165878 using(v36));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v37) as v59,MIN(v60) as v60 from aggJoin4221116521748696369;
