create or replace view aggJoin3054902898897212474 as (
with aggView8162658775058436760 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView8162658775058436760 where t.kind_id=aggView8162658775058436760.v26 and production_year>2000);
create or replace view aggJoin4028015884514891204 as (
with aggView8027776369140709969 as (select v40, MIN(v41) as v52 from aggJoin3054902898897212474 group by v40)
select movie_id as v40, keyword_id as v23, v52 from movie_keyword as mk, aggView8027776369140709969 where mk.movie_id=aggView8027776369140709969.v40);
create or replace view aggJoin1655737764434808491 as (
with aggView8890982115918025484 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select person_id as v31, movie_id as v40 from cast_info as ci, aggView8890982115918025484 where ci.person_role_id=aggView8890982115918025484.v9);
create or replace view aggJoin492680729254419604 as (
with aggView3427373645817537086 as (select id as v31 from name as n where name LIKE '%Downey%Robert%')
select v40 from aggJoin1655737764434808491 join aggView3427373645817537086 using(v31));
create or replace view aggJoin8866811240468837119 as (
with aggView4915174194393433854 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView4915174194393433854 where cc.status_id=aggView4915174194393433854.v7);
create or replace view aggJoin722899044957682456 as (
with aggView5176873707271387013 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin8866811240468837119 join aggView5176873707271387013 using(v5));
create or replace view aggJoin8857731192407816914 as (
with aggView3250755281133665396 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40, v52 from aggJoin4028015884514891204 join aggView3250755281133665396 using(v23));
create or replace view aggJoin5164976987429429629 as (
with aggView6415174242232632588 as (select v40, MIN(v52) as v52 from aggJoin8857731192407816914 group by v40,v52)
select v40, v52 from aggJoin722899044957682456 join aggView6415174242232632588 using(v40));
create or replace view aggJoin1816054161233234047 as (
with aggView5269764261057979445 as (select v40, MIN(v52) as v52 from aggJoin5164976987429429629 group by v40,v52)
select v52 from aggJoin492680729254419604 join aggView5269764261057979445 using(v40));
select MIN(v52) as v52 from aggJoin1816054161233234047;
