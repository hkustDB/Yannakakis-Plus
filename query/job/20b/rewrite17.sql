create or replace view aggJoin5522642965504715553 as (
with aggView4990257559280179073 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView4990257559280179073 where t.kind_id=aggView4990257559280179073.v26 and production_year>2000);
create or replace view aggJoin7604136492727005201 as (
with aggView2195803290334251394 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select person_id as v31, movie_id as v40 from cast_info as ci, aggView2195803290334251394 where ci.person_role_id=aggView2195803290334251394.v9);
create or replace view aggJoin4500373553300196308 as (
with aggView6393710545512105180 as (select id as v31 from name as n where name LIKE '%Downey%Robert%')
select v40 from aggJoin7604136492727005201 join aggView6393710545512105180 using(v31));
create or replace view aggJoin6534956959508676830 as (
with aggView3830959823722685060 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView3830959823722685060 where cc.status_id=aggView3830959823722685060.v7);
create or replace view aggJoin8215255843485799617 as (
with aggView5275791083810625576 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin6534956959508676830 join aggView5275791083810625576 using(v5));
create or replace view aggJoin3156225364637605973 as (
with aggView7613742724224549600 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select movie_id as v40 from movie_keyword as mk, aggView7613742724224549600 where mk.keyword_id=aggView7613742724224549600.v23);
create or replace view aggJoin4964071674223437578 as (
with aggView4904243773007638027 as (select v40 from aggJoin3156225364637605973 group by v40)
select v40, v41, v44 from aggJoin5522642965504715553 join aggView4904243773007638027 using(v40));
create or replace view aggJoin5158562121528151738 as (
with aggView7788890454818501359 as (select v40, MIN(v41) as v52 from aggJoin4964071674223437578 group by v40)
select v40, v52 from aggJoin8215255843485799617 join aggView7788890454818501359 using(v40));
create or replace view aggJoin3471381186383062045 as (
with aggView5251761191897956880 as (select v40, MIN(v52) as v52 from aggJoin5158562121528151738 group by v40,v52)
select v52 from aggJoin4500373553300196308 join aggView5251761191897956880 using(v40));
select MIN(v52) as v52 from aggJoin3471381186383062045;
