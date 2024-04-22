create or replace view aggJoin6507801209161412716 as (
with aggView6177945701453673636 as (select id as v31, name as v52 from name as n)
select movie_id as v40, person_role_id as v9, v52 from cast_info as ci, aggView6177945701453673636 where ci.person_id=aggView6177945701453673636.v31);
create or replace view aggJoin7441348415180095105 as (
with aggView8238676360411534491 as (select id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select v40, v52 from aggJoin6507801209161412716 join aggView8238676360411534491 using(v9));
create or replace view aggJoin3759483726818471903 as (
with aggView1425518186558758868 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView1425518186558758868 where t.kind_id=aggView1425518186558758868.v26 and production_year>2000);
create or replace view aggJoin7944462486906109287 as (
with aggView2798437009323816421 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView2798437009323816421 where cc.status_id=aggView2798437009323816421.v7);
create or replace view aggJoin9106071979228897082 as (
with aggView2950588203303075879 as (select id as v23 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v40 from movie_keyword as mk, aggView2950588203303075879 where mk.keyword_id=aggView2950588203303075879.v23);
create or replace view aggJoin6490832566488683694 as (
with aggView86310556840341038 as (select v40 from aggJoin9106071979228897082 group by v40)
select v40, v5 from aggJoin7944462486906109287 join aggView86310556840341038 using(v40));
create or replace view aggJoin3531662766484236193 as (
with aggView2026247869219756655 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin6490832566488683694 join aggView2026247869219756655 using(v5));
create or replace view aggJoin1168533222427854302 as (
with aggView4779967767093223604 as (select v40 from aggJoin3531662766484236193 group by v40)
select v40, v41, v44 from aggJoin3759483726818471903 join aggView4779967767093223604 using(v40));
create or replace view aggJoin600718529671525607 as (
with aggView1281009726347464131 as (select v40, MIN(v41) as v53 from aggJoin1168533222427854302 group by v40)
select v52 as v52, v53 from aggJoin7441348415180095105 join aggView1281009726347464131 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin600718529671525607;
