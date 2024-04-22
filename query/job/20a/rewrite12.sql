create or replace view aggJoin8150884994539479746 as (
with aggView5126293318835641090 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v40, status_id as v7 from complete_cast as cc, aggView5126293318835641090 where cc.subject_id=aggView5126293318835641090.v5);
create or replace view aggJoin1312998696646105661 as (
with aggView1217203046398343748 as (select id as v31 from name as n)
select movie_id as v40, person_role_id as v9 from cast_info as ci, aggView1217203046398343748 where ci.person_id=aggView1217203046398343748.v31);
create or replace view aggJoin3710903020499821141 as (
with aggView4181511008202290615 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40 from aggJoin8150884994539479746 join aggView4181511008202290615 using(v7));
create or replace view aggJoin6194296296396219654 as (
with aggView2324840957574324582 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView2324840957574324582 where t.kind_id=aggView2324840957574324582.v26 and production_year>1950);
create or replace view aggJoin141843409776989836 as (
with aggView8972684472656846905 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select v40 from aggJoin1312998696646105661 join aggView8972684472656846905 using(v9));
create or replace view aggJoin4138214325248772492 as (
with aggView7993111671447078001 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select movie_id as v40 from movie_keyword as mk, aggView7993111671447078001 where mk.keyword_id=aggView7993111671447078001.v23);
create or replace view aggJoin5700005191567846625 as (
with aggView3641923550247222840 as (select v40 from aggJoin4138214325248772492 group by v40)
select v40 from aggJoin3710903020499821141 join aggView3641923550247222840 using(v40));
create or replace view aggJoin7930479293738425584 as (
with aggView4143761236787619934 as (select v40 from aggJoin5700005191567846625 group by v40)
select v40, v41, v44 from aggJoin6194296296396219654 join aggView4143761236787619934 using(v40));
create or replace view aggJoin7490406110151850543 as (
with aggView8295083734081754278 as (select v40, MIN(v41) as v52 from aggJoin7930479293738425584 group by v40)
select v52 from aggJoin141843409776989836 join aggView8295083734081754278 using(v40));
select MIN(v52) as v52 from aggJoin7490406110151850543;
