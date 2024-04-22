create or replace view aggJoin5541331973984347071 as (
with aggView6484675639160814959 as (select id as v45, title as v60 from title as t where ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000)
select person_id as v36, movie_id as v45, note as v13, v60 from cast_info as ci, aggView6484675639160814959 where ci.movie_id=aggView6484675639160814959.v45 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin1974734834863585179 as (
with aggView4488565497591539267 as (select id as v36, name as v59 from name as n where gender= 'm')
select v45, v13, v60, v59 from aggJoin5541331973984347071 join aggView4488565497591539267 using(v36));
create or replace view aggJoin1258860157789169710 as (
with aggView4336304893858633399 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView4336304893858633399 where cc.status_id=aggView4336304893858633399.v7);
create or replace view aggJoin6841315621561786759 as (
with aggView8081523742603545222 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView8081523742603545222 where mk.keyword_id=aggView8081523742603545222.v20);
create or replace view aggJoin8707387798769784383 as (
with aggView3847567380555472819 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView3847567380555472819 where mi.info_type_id=aggView3847567380555472819.v16 and info IN ('Horror','Thriller'));
create or replace view aggJoin1699395691385853350 as (
with aggView4842678572874019636 as (select v45, MIN(v60) as v60, MIN(v59) as v59 from aggJoin1974734834863585179 group by v45,v59,v60)
select v45, v60, v59 from aggJoin6841315621561786759 join aggView4842678572874019636 using(v45));
create or replace view aggJoin210080367068384710 as (
with aggView8172755789297722492 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v45 from aggJoin1258860157789169710 join aggView8172755789297722492 using(v5));
create or replace view aggJoin5121403198713162312 as (
with aggView2091571417947108084 as (select v45 from aggJoin210080367068384710 group by v45)
select movie_id as v45, info_type_id as v18, info as v31 from movie_info_idx as mi_idx, aggView2091571417947108084 where mi_idx.movie_id=aggView2091571417947108084.v45);
create or replace view aggJoin7007818642701532697 as (
with aggView2743738049356967820 as (select id as v18 from info_type as it2 where info= 'votes')
select v45, v31 from aggJoin5121403198713162312 join aggView2743738049356967820 using(v18));
create or replace view aggJoin5430875380342639975 as (
with aggView3455504660388303729 as (select v45, MIN(v31) as v58 from aggJoin7007818642701532697 group by v45)
select v45, v26, v58 from aggJoin8707387798769784383 join aggView3455504660388303729 using(v45));
create or replace view aggJoin1608813288834966008 as (
with aggView8851390723556065314 as (select v45, MIN(v58) as v58, MIN(v26) as v57 from aggJoin5430875380342639975 group by v45,v58)
select v60 as v60, v59 as v59, v58, v57 from aggJoin1699395691385853350 join aggView8851390723556065314 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin1608813288834966008;
