create or replace view aggView6988258893689857587 as select name as v32, id as v31 from name as n;
create or replace view aggJoin4638093908408304257 as (
with aggView3268693042463804735 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView3268693042463804735 where t.kind_id=aggView3268693042463804735.v26 and production_year>2000);
create or replace view aggJoin5677960359109749429 as (
with aggView2724905430170884885 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView2724905430170884885 where cc.status_id=aggView2724905430170884885.v7);
create or replace view aggJoin5769731496814533164 as (
with aggView5375380973750831452 as (select id as v23 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v40 from movie_keyword as mk, aggView5375380973750831452 where mk.keyword_id=aggView5375380973750831452.v23);
create or replace view aggJoin2047970439524435592 as (
with aggView4067764919309505350 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin5677960359109749429 join aggView4067764919309505350 using(v5));
create or replace view aggJoin3440040165426483971 as (
with aggView7848399541602094823 as (select v40 from aggJoin2047970439524435592 group by v40)
select v40 from aggJoin5769731496814533164 join aggView7848399541602094823 using(v40));
create or replace view aggJoin7614865055104059696 as (
with aggView5818637462740412666 as (select v40 from aggJoin3440040165426483971 group by v40)
select v40, v41, v44 from aggJoin4638093908408304257 join aggView5818637462740412666 using(v40));
create or replace view aggView261600282943600729 as select v40, v41 from aggJoin7614865055104059696 group by v40,v41;
create or replace view aggJoin3840069129324002640 as (
with aggView7784688263230849079 as (select v40, MIN(v41) as v53 from aggView261600282943600729 group by v40)
select person_id as v31, person_role_id as v9, v53 from cast_info as ci, aggView7784688263230849079 where ci.movie_id=aggView7784688263230849079.v40);
create or replace view aggJoin5970495826898431902 as (
with aggView6512502487808814382 as (select id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select v31, v53 from aggJoin3840069129324002640 join aggView6512502487808814382 using(v9));
create or replace view aggJoin7420344914275612338 as (
with aggView4376440984241140777 as (select v31, MIN(v53) as v53 from aggJoin5970495826898431902 group by v31,v53)
select v32, v53 from aggView6988258893689857587 join aggView4376440984241140777 using(v31));
select MIN(v32) as v52,MIN(v53) as v53 from aggJoin7420344914275612338;
