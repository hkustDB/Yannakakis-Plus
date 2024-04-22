create or replace view aggJoin1656282587829451941 as (
with aggView1397022026034301635 as (select id as v31, name as v52 from name as n)
select movie_id as v40, person_role_id as v9, v52 from cast_info as ci, aggView1397022026034301635 where ci.person_id=aggView1397022026034301635.v31);
create or replace view aggJoin1621906727828382810 as (
with aggView8595873390296862841 as (select id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select v40, v52 from aggJoin1656282587829451941 join aggView8595873390296862841 using(v9));
create or replace view aggJoin7839523280958059884 as (
with aggView7459268062778521842 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView7459268062778521842 where t.kind_id=aggView7459268062778521842.v26 and production_year>2000);
create or replace view aggJoin3457615171164588533 as (
with aggView8763225660720728493 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView8763225660720728493 where cc.status_id=aggView8763225660720728493.v7);
create or replace view aggJoin2902562244065105892 as (
with aggView8739449601785325066 as (select id as v23 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v40 from movie_keyword as mk, aggView8739449601785325066 where mk.keyword_id=aggView8739449601785325066.v23);
create or replace view aggJoin2866823775418552793 as (
with aggView1959503901919945603 as (select v40 from aggJoin2902562244065105892 group by v40)
select v40, v41, v44 from aggJoin7839523280958059884 join aggView1959503901919945603 using(v40));
create or replace view aggJoin2956341334145631349 as (
with aggView4903055120409753162 as (select v40, MIN(v41) as v53 from aggJoin2866823775418552793 group by v40)
select v40, v5, v53 from aggJoin3457615171164588533 join aggView4903055120409753162 using(v40));
create or replace view aggJoin1537382524611360960 as (
with aggView4015455789318715667 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40, v53 from aggJoin2956341334145631349 join aggView4015455789318715667 using(v5));
create or replace view aggJoin1767367919766089090 as (
with aggView9116309606063970146 as (select v40, MIN(v53) as v53 from aggJoin1537382524611360960 group by v40,v53)
select v52 as v52, v53 from aggJoin1621906727828382810 join aggView9116309606063970146 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin1767367919766089090;
