create or replace view aggJoin5839226613244678971 as (
with aggView3298862568761240582 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView3298862568761240582 where ci.person_role_id=aggView3298862568761240582.v9);
create or replace view aggJoin9167017576927014300 as (
with aggView2485332849120627900 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView2485332849120627900 where cc.status_id=aggView2485332849120627900.v7);
create or replace view aggJoin343755691473036610 as (
with aggView1384567068252382392 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin9167017576927014300 join aggView1384567068252382392 using(v5));
create or replace view aggJoin3198213626019993145 as (
with aggView9189933807370363230 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView9189933807370363230 where mi_idx.info_type_id=aggView9189933807370363230.v23);
create or replace view aggJoin6701666791021029770 as (
with aggView4477456080413162960 as (select v47, MIN(v33) as v60 from aggJoin3198213626019993145 group by v47)
select movie_id as v47, keyword_id as v25, v60 from movie_keyword as mk, aggView4477456080413162960 where mk.movie_id=aggView4477456080413162960.v47);
create or replace view aggJoin8666413686930944978 as (
with aggView4447444258968083263 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView4447444258968083263 where t.kind_id=aggView4447444258968083263.v28 and production_year>2000);
create or replace view aggJoin2566439614131628905 as (
with aggView933350811832296627 as (select v47, MIN(v48) as v61 from aggJoin8666413686930944978 group by v47)
select v47, v61 from aggJoin343755691473036610 join aggView933350811832296627 using(v47));
create or replace view aggJoin6100308517623827866 as (
with aggView3889870628027508782 as (select v47, MIN(v61) as v61 from aggJoin2566439614131628905 group by v47,v61)
select v47, v25, v60 as v60, v61 from aggJoin6701666791021029770 join aggView3889870628027508782 using(v47));
create or replace view aggJoin6343468999764226055 as (
with aggView4883097962066060970 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select v47, v60, v61 from aggJoin6100308517623827866 join aggView4883097962066060970 using(v25));
create or replace view aggJoin6942191518472911555 as (
with aggView8652993385101187228 as (select v47, MIN(v60) as v60, MIN(v61) as v61 from aggJoin6343468999764226055 group by v47,v61,v60)
select v38, v59 as v59, v60, v61 from aggJoin5839226613244678971 join aggView8652993385101187228 using(v47));
create or replace view aggJoin3636999440443094008 as (
with aggView6487188936575178990 as (select id as v38 from name as n)
select v59, v60, v61 from aggJoin6942191518472911555 join aggView6487188936575178990 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin3636999440443094008;
