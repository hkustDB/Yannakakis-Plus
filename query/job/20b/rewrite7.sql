create or replace view aggJoin490228003078611170 as (
with aggView7245142397685688280 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView7245142397685688280 where t.kind_id=aggView7245142397685688280.v26 and production_year>2000);
create or replace view aggJoin7098545615552212095 as (
with aggView3618558722775298701 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select person_id as v31, movie_id as v40 from cast_info as ci, aggView3618558722775298701 where ci.person_role_id=aggView3618558722775298701.v9);
create or replace view aggJoin51631854443714223 as (
with aggView3651100926101636222 as (select id as v31 from name as n where name LIKE '%Downey%Robert%')
select v40 from aggJoin7098545615552212095 join aggView3651100926101636222 using(v31));
create or replace view aggJoin2809865187407787683 as (
with aggView8489947153371081474 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView8489947153371081474 where cc.status_id=aggView8489947153371081474.v7);
create or replace view aggJoin3771395926521309637 as (
with aggView647143579097556261 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin2809865187407787683 join aggView647143579097556261 using(v5));
create or replace view aggJoin8399101763199279555 as (
with aggView7982389316313369159 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select movie_id as v40 from movie_keyword as mk, aggView7982389316313369159 where mk.keyword_id=aggView7982389316313369159.v23);
create or replace view aggJoin2800625735281220729 as (
with aggView1058788920723508044 as (select v40 from aggJoin8399101763199279555 group by v40)
select v40 from aggJoin51631854443714223 join aggView1058788920723508044 using(v40));
create or replace view aggJoin8099972136020866236 as (
with aggView2499202373971608646 as (select v40 from aggJoin2800625735281220729 group by v40)
select v40 from aggJoin3771395926521309637 join aggView2499202373971608646 using(v40));
create or replace view aggJoin6015222358994191854 as (
with aggView4519230877811177022 as (select v40 from aggJoin8099972136020866236 group by v40)
select v41, v44 from aggJoin490228003078611170 join aggView4519230877811177022 using(v40));
create or replace view aggView7444531935422680428 as select v41 from aggJoin6015222358994191854 group by v41;
select MIN(v41) as v52 from aggView7444531935422680428;
