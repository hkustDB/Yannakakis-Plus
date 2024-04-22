create or replace view aggJoin3879372564809196947 as (
with aggView8984697058206517433 as (select id as v36, name as v59 from name as n where gender= 'm')
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView8984697058206517433 where ci.person_id=aggView8984697058206517433.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin1302838043895131762 as (
with aggView3745480710212304774 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView3745480710212304774 where cc.status_id=aggView3745480710212304774.v7);
create or replace view aggJoin3251646278944371477 as (
with aggView2795627349793486562 as (select v45, MIN(v59) as v59 from aggJoin3879372564809196947 group by v45,v59)
select v45, v5, v59 from aggJoin1302838043895131762 join aggView2795627349793486562 using(v45));
create or replace view aggJoin5374214980732376916 as (
with aggView1048972974413262092 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView1048972974413262092 where mk.keyword_id=aggView1048972974413262092.v20);
create or replace view aggJoin8215304772001223565 as (
with aggView9183097078258374803 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView9183097078258374803 where mi.info_type_id=aggView9183097078258374803.v16 and info IN ('Horror','Thriller'));
create or replace view aggJoin1774911897891035003 as (
with aggView8618312982277785758 as (select v45, MIN(v26) as v57 from aggJoin8215304772001223565 group by v45)
select id as v45, title as v46, production_year as v49, v57 from title as t, aggView8618312982277785758 where t.id=aggView8618312982277785758.v45 and ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000);
create or replace view aggJoin6124767950614757214 as (
with aggView2377679061852141963 as (select v45, MIN(v57) as v57, MIN(v46) as v60 from aggJoin1774911897891035003 group by v45,v57)
select movie_id as v45, info_type_id as v18, info as v31, v57, v60 from movie_info_idx as mi_idx, aggView2377679061852141963 where mi_idx.movie_id=aggView2377679061852141963.v45);
create or replace view aggJoin2190875845773669854 as (
with aggView3593608331881362358 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v45, v59 from aggJoin3251646278944371477 join aggView3593608331881362358 using(v5));
create or replace view aggJoin6445242460943486299 as (
with aggView5506853580239870733 as (select id as v18 from info_type as it2 where info= 'votes')
select v45, v31, v57, v60 from aggJoin6124767950614757214 join aggView5506853580239870733 using(v18));
create or replace view aggJoin7736300145324131498 as (
with aggView5892996430127673987 as (select v45, MIN(v57) as v57, MIN(v60) as v60, MIN(v31) as v58 from aggJoin6445242460943486299 group by v45,v60,v57)
select v45, v59 as v59, v57, v60, v58 from aggJoin2190875845773669854 join aggView5892996430127673987 using(v45));
create or replace view aggJoin2929905697030983065 as (
with aggView930487012113713928 as (select v45, MIN(v59) as v59, MIN(v57) as v57, MIN(v60) as v60, MIN(v58) as v58 from aggJoin7736300145324131498 group by v45,v58,v59,v60,v57)
select v59, v57, v60, v58 from aggJoin5374214980732376916 join aggView930487012113713928 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin2929905697030983065;
