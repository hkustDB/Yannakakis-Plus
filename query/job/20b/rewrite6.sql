create or replace view aggJoin7686194099564704295 as (
with aggView6617648354415824916 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView6617648354415824916 where t.kind_id=aggView6617648354415824916.v26 and production_year>2000);
create or replace view aggJoin118745647211340988 as (
with aggView4025825997480255427 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select person_id as v31, movie_id as v40 from cast_info as ci, aggView4025825997480255427 where ci.person_role_id=aggView4025825997480255427.v9);
create or replace view aggJoin3131513105425449088 as (
with aggView5202973460760196730 as (select id as v31 from name as n where name LIKE '%Downey%Robert%')
select v40 from aggJoin118745647211340988 join aggView5202973460760196730 using(v31));
create or replace view aggJoin7413168939628051566 as (
with aggView4920623098391056559 as (select v40 from aggJoin3131513105425449088 group by v40)
select v40, v41, v44 from aggJoin7686194099564704295 join aggView4920623098391056559 using(v40));
create or replace view aggJoin7371704410101043709 as (
with aggView3596678700145764103 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView3596678700145764103 where cc.status_id=aggView3596678700145764103.v7);
create or replace view aggJoin6183345308347272168 as (
with aggView3414285568897997677 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin7371704410101043709 join aggView3414285568897997677 using(v5));
create or replace view aggJoin7408248897652350524 as (
with aggView1826620828355000047 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select movie_id as v40 from movie_keyword as mk, aggView1826620828355000047 where mk.keyword_id=aggView1826620828355000047.v23);
create or replace view aggJoin3312200408301360483 as (
with aggView5855286565914265023 as (select v40 from aggJoin7408248897652350524 group by v40)
select v40 from aggJoin6183345308347272168 join aggView5855286565914265023 using(v40));
create or replace view aggJoin6050151347792037601 as (
with aggView4857159223534298215 as (select v40 from aggJoin3312200408301360483 group by v40)
select v41, v44 from aggJoin7413168939628051566 join aggView4857159223534298215 using(v40));
create or replace view aggView9102507250501901948 as select v41 from aggJoin6050151347792037601 group by v41;
select MIN(v41) as v52 from aggView9102507250501901948;
