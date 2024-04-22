create or replace view aggJoin1104955885097384754 as (
with aggView4402873239862743274 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView4402873239862743274 where t.kind_id=aggView4402873239862743274.v26 and production_year>2000);
create or replace view aggJoin333987089983383821 as (
with aggView3985647918493129015 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select person_id as v31, movie_id as v40 from cast_info as ci, aggView3985647918493129015 where ci.person_role_id=aggView3985647918493129015.v9);
create or replace view aggJoin2812861022168775606 as (
with aggView6365295136464606914 as (select id as v31 from name as n where name LIKE '%Downey%Robert%')
select v40 from aggJoin333987089983383821 join aggView6365295136464606914 using(v31));
create or replace view aggJoin7700562374658085215 as (
with aggView7437995965233927012 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView7437995965233927012 where cc.status_id=aggView7437995965233927012.v7);
create or replace view aggJoin8912127008364620798 as (
with aggView1877991248176715000 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin7700562374658085215 join aggView1877991248176715000 using(v5));
create or replace view aggJoin6187689319248971504 as (
with aggView463684704355430423 as (select v40 from aggJoin8912127008364620798 group by v40)
select v40 from aggJoin2812861022168775606 join aggView463684704355430423 using(v40));
create or replace view aggJoin881199685502035728 as (
with aggView1012324497580849649 as (select v40 from aggJoin6187689319248971504 group by v40)
select movie_id as v40, keyword_id as v23 from movie_keyword as mk, aggView1012324497580849649 where mk.movie_id=aggView1012324497580849649.v40);
create or replace view aggJoin1265075541129235134 as (
with aggView5474790530659513886 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40 from aggJoin881199685502035728 join aggView5474790530659513886 using(v23));
create or replace view aggJoin8648933919704392635 as (
with aggView8334551908233363359 as (select v40 from aggJoin1265075541129235134 group by v40)
select v41, v44 from aggJoin1104955885097384754 join aggView8334551908233363359 using(v40));
create or replace view aggView7992073160079639092 as select v41 from aggJoin8648933919704392635 group by v41;
select MIN(v41) as v52 from aggView7992073160079639092;
