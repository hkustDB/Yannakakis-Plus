create or replace view aggView5947915130683262500 as select name as v32, id as v31 from name as n;
create or replace view aggJoin8172621997178898854 as (
with aggView1708538419291714657 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView1708538419291714657 where t.kind_id=aggView1708538419291714657.v26 and production_year>2000);
create or replace view aggJoin4449466860495741211 as (
with aggView2723995576670371658 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView2723995576670371658 where cc.status_id=aggView2723995576670371658.v7);
create or replace view aggJoin132506647743096952 as (
with aggView3355330988509611718 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin4449466860495741211 join aggView3355330988509611718 using(v5));
create or replace view aggJoin9050990786101489482 as (
with aggView8879911082953288300 as (select v40 from aggJoin132506647743096952 group by v40)
select v40, v41, v44 from aggJoin8172621997178898854 join aggView8879911082953288300 using(v40));
create or replace view aggView74562051249675827 as select v40, v41 from aggJoin9050990786101489482 group by v40,v41;
create or replace view aggJoin3431950757479155704 as (
with aggView8506793674900925006 as (select v40, MIN(v41) as v53 from aggView74562051249675827 group by v40)
select person_id as v31, movie_id as v40, person_role_id as v9, v53 from cast_info as ci, aggView8506793674900925006 where ci.movie_id=aggView8506793674900925006.v40);
create or replace view aggJoin6271473865808398851 as (
with aggView2966215627143379366 as (select id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select v31, v40, v53 from aggJoin3431950757479155704 join aggView2966215627143379366 using(v9));
create or replace view aggJoin5588641508816816992 as (
with aggView1608539999365282585 as (select id as v23 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v40 from movie_keyword as mk, aggView1608539999365282585 where mk.keyword_id=aggView1608539999365282585.v23);
create or replace view aggJoin4896011467732876814 as (
with aggView2206468496901703082 as (select v40 from aggJoin5588641508816816992 group by v40)
select v31, v53 as v53 from aggJoin6271473865808398851 join aggView2206468496901703082 using(v40));
create or replace view aggJoin1625854711714274052 as (
with aggView1804443790108888187 as (select v31, MIN(v53) as v53 from aggJoin4896011467732876814 group by v31,v53)
select v32, v53 from aggView5947915130683262500 join aggView1804443790108888187 using(v31));
select MIN(v32) as v52,MIN(v53) as v53 from aggJoin1625854711714274052;
