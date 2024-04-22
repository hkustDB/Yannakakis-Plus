create or replace view aggJoin3749065909617696605 as (
with aggView2899580276110226279 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView2899580276110226279 where t.kind_id=aggView2899580276110226279.v26 and production_year>2000);
create or replace view aggJoin5436678097842737710 as (
with aggView6446560419481580409 as (select v40, MIN(v41) as v52 from aggJoin3749065909617696605 group by v40)
select movie_id as v40, subject_id as v5, status_id as v7, v52 from complete_cast as cc, aggView6446560419481580409 where cc.movie_id=aggView6446560419481580409.v40);
create or replace view aggJoin2284139351649255814 as (
with aggView6951904742430988700 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select person_id as v31, movie_id as v40 from cast_info as ci, aggView6951904742430988700 where ci.person_role_id=aggView6951904742430988700.v9);
create or replace view aggJoin4853146522214141179 as (
with aggView6080277167472740739 as (select id as v31 from name as n where name LIKE '%Downey%Robert%')
select v40 from aggJoin2284139351649255814 join aggView6080277167472740739 using(v31));
create or replace view aggJoin1542541443303698755 as (
with aggView6233852600594590285 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40, v5, v52 from aggJoin5436678097842737710 join aggView6233852600594590285 using(v7));
create or replace view aggJoin3460234595273155359 as (
with aggView3200900167125204982 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40, v52 from aggJoin1542541443303698755 join aggView3200900167125204982 using(v5));
create or replace view aggJoin9126084537387836766 as (
with aggView4642631442848594232 as (select v40, MIN(v52) as v52 from aggJoin3460234595273155359 group by v40,v52)
select movie_id as v40, keyword_id as v23, v52 from movie_keyword as mk, aggView4642631442848594232 where mk.movie_id=aggView4642631442848594232.v40);
create or replace view aggJoin1347331544631965555 as (
with aggView7471613651519438999 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40, v52 from aggJoin9126084537387836766 join aggView7471613651519438999 using(v23));
create or replace view aggJoin3089584486994815692 as (
with aggView1061006462298805010 as (select v40, MIN(v52) as v52 from aggJoin1347331544631965555 group by v40,v52)
select v52 from aggJoin4853146522214141179 join aggView1061006462298805010 using(v40));
select MIN(v52) as v52 from aggJoin3089584486994815692;
