create or replace view aggJoin6586706660222043909 as (
with aggView2426301536232497677 as (select id as v31, name as v52 from name as n)
select movie_id as v40, person_role_id as v9, v52 from cast_info as ci, aggView2426301536232497677 where ci.person_id=aggView2426301536232497677.v31);
create or replace view aggJoin8273934625880806497 as (
with aggView5970854853543309993 as (select id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select v40, v52 from aggJoin6586706660222043909 join aggView5970854853543309993 using(v9));
create or replace view aggJoin974322019418759482 as (
with aggView8739180867125379828 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView8739180867125379828 where t.kind_id=aggView8739180867125379828.v26 and production_year>2000);
create or replace view aggJoin3874092628427359306 as (
with aggView3123820259445033644 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView3123820259445033644 where cc.status_id=aggView3123820259445033644.v7);
create or replace view aggJoin7019955397864040837 as (
with aggView4563115782114599442 as (select id as v23 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v40 from movie_keyword as mk, aggView4563115782114599442 where mk.keyword_id=aggView4563115782114599442.v23);
create or replace view aggJoin9070845555436899948 as (
with aggView5612016357464952994 as (select v40 from aggJoin7019955397864040837 group by v40)
select v40, v41, v44 from aggJoin974322019418759482 join aggView5612016357464952994 using(v40));
create or replace view aggJoin721883152325359457 as (
with aggView5375594537740965073 as (select v40, MIN(v41) as v53 from aggJoin9070845555436899948 group by v40)
select v40, v52 as v52, v53 from aggJoin8273934625880806497 join aggView5375594537740965073 using(v40));
create or replace view aggJoin318822577154568502 as (
with aggView6735441061286716259 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin3874092628427359306 join aggView6735441061286716259 using(v5));
create or replace view aggJoin5070310019297043721 as (
with aggView5148068012857182234 as (select v40 from aggJoin318822577154568502 group by v40)
select v52 as v52, v53 as v53 from aggJoin721883152325359457 join aggView5148068012857182234 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin5070310019297043721;
