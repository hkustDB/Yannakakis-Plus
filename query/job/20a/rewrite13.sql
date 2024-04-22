create or replace view aggJoin6157417941757193083 as (
with aggView6030241096060015388 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v40, status_id as v7 from complete_cast as cc, aggView6030241096060015388 where cc.subject_id=aggView6030241096060015388.v5);
create or replace view aggJoin1073142783412001336 as (
with aggView8833207763396686430 as (select id as v31 from name as n)
select movie_id as v40, person_role_id as v9 from cast_info as ci, aggView8833207763396686430 where ci.person_id=aggView8833207763396686430.v31);
create or replace view aggJoin3213430410777192225 as (
with aggView5790456385438825133 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40 from aggJoin6157417941757193083 join aggView5790456385438825133 using(v7));
create or replace view aggJoin9016182837629901551 as (
with aggView379855190000128850 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView379855190000128850 where t.kind_id=aggView379855190000128850.v26 and production_year>1950);
create or replace view aggJoin6196689451530019571 as (
with aggView7682249099876712146 as (select v40, MIN(v41) as v52 from aggJoin9016182837629901551 group by v40)
select movie_id as v40, keyword_id as v23, v52 from movie_keyword as mk, aggView7682249099876712146 where mk.movie_id=aggView7682249099876712146.v40);
create or replace view aggJoin6442391790878734730 as (
with aggView8561178647711467504 as (select v40 from aggJoin3213430410777192225 group by v40)
select v40, v23, v52 as v52 from aggJoin6196689451530019571 join aggView8561178647711467504 using(v40));
create or replace view aggJoin3022302156446077594 as (
with aggView8623380767292116148 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select v40 from aggJoin1073142783412001336 join aggView8623380767292116148 using(v9));
create or replace view aggJoin4128553815253511033 as (
with aggView890895504636018304 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40, v52 from aggJoin6442391790878734730 join aggView890895504636018304 using(v23));
create or replace view aggJoin4651108147145845556 as (
with aggView5943772259844521423 as (select v40, MIN(v52) as v52 from aggJoin4128553815253511033 group by v40,v52)
select v52 from aggJoin3022302156446077594 join aggView5943772259844521423 using(v40));
select MIN(v52) as v52 from aggJoin4651108147145845556;
