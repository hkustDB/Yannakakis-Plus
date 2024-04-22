create or replace view aggJoin8519271256006360399 as (
with aggView5049786134925640644 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v40, status_id as v7 from complete_cast as cc, aggView5049786134925640644 where cc.subject_id=aggView5049786134925640644.v5);
create or replace view aggJoin2398385638539214137 as (
with aggView5991424788411363865 as (select id as v31 from name as n)
select movie_id as v40, person_role_id as v9 from cast_info as ci, aggView5991424788411363865 where ci.person_id=aggView5991424788411363865.v31);
create or replace view aggJoin8639069122379006211 as (
with aggView7592706997152186313 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40 from aggJoin8519271256006360399 join aggView7592706997152186313 using(v7));
create or replace view aggJoin1096195374792298379 as (
with aggView3039117842675784306 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView3039117842675784306 where t.kind_id=aggView3039117842675784306.v26 and production_year>1950);
create or replace view aggJoin8875743382773480241 as (
with aggView6815131980185000910 as (select v40, MIN(v41) as v52 from aggJoin1096195374792298379 group by v40)
select v40, v52 from aggJoin8639069122379006211 join aggView6815131980185000910 using(v40));
create or replace view aggJoin246777010429446057 as (
with aggView6600123511593016907 as (select v40, MIN(v52) as v52 from aggJoin8875743382773480241 group by v40,v52)
select movie_id as v40, keyword_id as v23, v52 from movie_keyword as mk, aggView6600123511593016907 where mk.movie_id=aggView6600123511593016907.v40);
create or replace view aggJoin5871986607462761050 as (
with aggView4094523544873374151 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select v40 from aggJoin2398385638539214137 join aggView4094523544873374151 using(v9));
create or replace view aggJoin3208333755821193392 as (
with aggView398947184847218424 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40, v52 from aggJoin246777010429446057 join aggView398947184847218424 using(v23));
create or replace view aggJoin2908138150533156993 as (
with aggView5142769840030273126 as (select v40, MIN(v52) as v52 from aggJoin3208333755821193392 group by v40,v52)
select v52 from aggJoin5871986607462761050 join aggView5142769840030273126 using(v40));
select MIN(v52) as v52 from aggJoin2908138150533156993;
