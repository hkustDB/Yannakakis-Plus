create or replace view aggJoin1340199820739900848 as (
with aggView85516351514948659 as (select id as v31, name as v52 from name as n)
select movie_id as v40, person_role_id as v9, v52 from cast_info as ci, aggView85516351514948659 where ci.person_id=aggView85516351514948659.v31);
create or replace view aggJoin8560174750666499747 as (
with aggView5049393931288416870 as (select id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select v40, v52 from aggJoin1340199820739900848 join aggView5049393931288416870 using(v9));
create or replace view aggJoin4903137991749259032 as (
with aggView9168209435918344539 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView9168209435918344539 where t.kind_id=aggView9168209435918344539.v26 and production_year>2000);
create or replace view aggJoin4805000982741591896 as (
with aggView2971203636321731178 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView2971203636321731178 where cc.status_id=aggView2971203636321731178.v7);
create or replace view aggJoin4738135452607656261 as (
with aggView6648089013243648928 as (select id as v23 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v40 from movie_keyword as mk, aggView6648089013243648928 where mk.keyword_id=aggView6648089013243648928.v23);
create or replace view aggJoin1797791903057958917 as (
with aggView1060985286025393122 as (select v40 from aggJoin4738135452607656261 group by v40)
select v40, v41, v44 from aggJoin4903137991749259032 join aggView1060985286025393122 using(v40));
create or replace view aggJoin8124077938174857784 as (
with aggView9007706101645367482 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin4805000982741591896 join aggView9007706101645367482 using(v5));
create or replace view aggJoin5312927840743154022 as (
with aggView5416138890606972686 as (select v40 from aggJoin8124077938174857784 group by v40)
select v40, v41, v44 from aggJoin1797791903057958917 join aggView5416138890606972686 using(v40));
create or replace view aggJoin1246159276306214655 as (
with aggView3301106878059562211 as (select v40, MIN(v41) as v53 from aggJoin5312927840743154022 group by v40)
select v52 as v52, v53 from aggJoin8560174750666499747 join aggView3301106878059562211 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin1246159276306214655;
