create or replace view aggJoin46151281994474516 as (
with aggView288002632531963400 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v40, status_id as v7 from complete_cast as cc, aggView288002632531963400 where cc.subject_id=aggView288002632531963400.v5);
create or replace view aggJoin1504070546831133871 as (
with aggView4302174563725685308 as (select id as v31 from name as n)
select movie_id as v40, person_role_id as v9 from cast_info as ci, aggView4302174563725685308 where ci.person_id=aggView4302174563725685308.v31);
create or replace view aggJoin3817749823264990121 as (
with aggView376289691170911308 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40 from aggJoin46151281994474516 join aggView376289691170911308 using(v7));
create or replace view aggJoin763842363220472777 as (
with aggView708922802333873510 as (select v40 from aggJoin3817749823264990121 group by v40)
select id as v40, title as v41, kind_id as v26, production_year as v44 from title as t, aggView708922802333873510 where t.id=aggView708922802333873510.v40 and production_year>1950);
create or replace view aggJoin444185201151052156 as (
with aggView8284808635477505863 as (select id as v26 from kind_type as kt where kind= 'movie')
select v40, v41, v44 from aggJoin763842363220472777 join aggView8284808635477505863 using(v26));
create or replace view aggJoin3734480918861048328 as (
with aggView2188760408441899704 as (select v40, MIN(v41) as v52 from aggJoin444185201151052156 group by v40)
select movie_id as v40, keyword_id as v23, v52 from movie_keyword as mk, aggView2188760408441899704 where mk.movie_id=aggView2188760408441899704.v40);
create or replace view aggJoin8309263519971850935 as (
with aggView7496311971987776028 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select v40 from aggJoin1504070546831133871 join aggView7496311971987776028 using(v9));
create or replace view aggJoin6816696313715277925 as (
with aggView6093020667329910780 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40, v52 from aggJoin3734480918861048328 join aggView6093020667329910780 using(v23));
create or replace view aggJoin3008435874621928768 as (
with aggView3125432866783985974 as (select v40, MIN(v52) as v52 from aggJoin6816696313715277925 group by v40,v52)
select v52 from aggJoin8309263519971850935 join aggView3125432866783985974 using(v40));
select MIN(v52) as v52 from aggJoin3008435874621928768;
