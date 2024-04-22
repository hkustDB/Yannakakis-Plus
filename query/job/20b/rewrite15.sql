create or replace view aggJoin8108347465780704790 as (
with aggView4027199324991306153 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView4027199324991306153 where t.kind_id=aggView4027199324991306153.v26 and production_year>2000);
create or replace view aggJoin2531269043359301633 as (
with aggView7127689728817731036 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select person_id as v31, movie_id as v40 from cast_info as ci, aggView7127689728817731036 where ci.person_role_id=aggView7127689728817731036.v9);
create or replace view aggJoin5240110193033127744 as (
with aggView1175718867414629722 as (select id as v31 from name as n where name LIKE '%Downey%Robert%')
select v40 from aggJoin2531269043359301633 join aggView1175718867414629722 using(v31));
create or replace view aggJoin3053337877447576230 as (
with aggView3462964479978937718 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView3462964479978937718 where cc.status_id=aggView3462964479978937718.v7);
create or replace view aggJoin1736025474987787003 as (
with aggView8213070667339767208 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin3053337877447576230 join aggView8213070667339767208 using(v5));
create or replace view aggJoin4096752034783452998 as (
with aggView7101067149499967172 as (select v40 from aggJoin1736025474987787003 group by v40)
select movie_id as v40, keyword_id as v23 from movie_keyword as mk, aggView7101067149499967172 where mk.movie_id=aggView7101067149499967172.v40);
create or replace view aggJoin115902020663643080 as (
with aggView5250052265531352350 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40 from aggJoin4096752034783452998 join aggView5250052265531352350 using(v23));
create or replace view aggJoin8666552566883180320 as (
with aggView9204876966566515924 as (select v40 from aggJoin115902020663643080 group by v40)
select v40, v41, v44 from aggJoin8108347465780704790 join aggView9204876966566515924 using(v40));
create or replace view aggJoin4754473029579332341 as (
with aggView4094569954455200886 as (select v40, MIN(v41) as v52 from aggJoin8666552566883180320 group by v40)
select v52 from aggJoin5240110193033127744 join aggView4094569954455200886 using(v40));
select MIN(v52) as v52 from aggJoin4754473029579332341;
