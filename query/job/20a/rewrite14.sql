create or replace view aggJoin5789072980355276118 as (
with aggView7666468144934976993 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v40, status_id as v7 from complete_cast as cc, aggView7666468144934976993 where cc.subject_id=aggView7666468144934976993.v5);
create or replace view aggJoin5504365627662323832 as (
with aggView1406960075276983699 as (select id as v31 from name as n)
select movie_id as v40, person_role_id as v9 from cast_info as ci, aggView1406960075276983699 where ci.person_id=aggView1406960075276983699.v31);
create or replace view aggJoin726888107869527235 as (
with aggView8842940005473121452 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40 from aggJoin5789072980355276118 join aggView8842940005473121452 using(v7));
create or replace view aggJoin4379512514648041254 as (
with aggView6599209769246545223 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView6599209769246545223 where t.kind_id=aggView6599209769246545223.v26 and production_year>1950);
create or replace view aggJoin8019295846797197078 as (
with aggView5925777300939345841 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select v40 from aggJoin5504365627662323832 join aggView5925777300939345841 using(v9));
create or replace view aggJoin920392313629553807 as (
with aggView8291968083504127516 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select movie_id as v40 from movie_keyword as mk, aggView8291968083504127516 where mk.keyword_id=aggView8291968083504127516.v23);
create or replace view aggJoin6560689629930108141 as (
with aggView8029927362587155959 as (select v40 from aggJoin920392313629553807 group by v40)
select v40, v41, v44 from aggJoin4379512514648041254 join aggView8029927362587155959 using(v40));
create or replace view aggJoin5591834128286419929 as (
with aggView6801266561885487013 as (select v40, MIN(v41) as v52 from aggJoin6560689629930108141 group by v40)
select v40, v52 from aggJoin726888107869527235 join aggView6801266561885487013 using(v40));
create or replace view aggJoin6760021926339060672 as (
with aggView4208761804305856466 as (select v40, MIN(v52) as v52 from aggJoin5591834128286419929 group by v40,v52)
select v52 from aggJoin8019295846797197078 join aggView4208761804305856466 using(v40));
select MIN(v52) as v52 from aggJoin6760021926339060672;
