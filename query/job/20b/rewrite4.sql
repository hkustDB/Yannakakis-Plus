create or replace view aggJoin3067249434787428567 as (
with aggView746435446060406084 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView746435446060406084 where t.kind_id=aggView746435446060406084.v26 and production_year>2000);
create or replace view aggJoin7985347600771770463 as (
with aggView8603824311845606085 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select person_id as v31, movie_id as v40 from cast_info as ci, aggView8603824311845606085 where ci.person_role_id=aggView8603824311845606085.v9);
create or replace view aggJoin2170259185098209171 as (
with aggView4131843503195502813 as (select id as v31 from name as n where name LIKE '%Downey%Robert%')
select v40 from aggJoin7985347600771770463 join aggView4131843503195502813 using(v31));
create or replace view aggJoin4174212229482086564 as (
with aggView1872189775503809281 as (select v40 from aggJoin2170259185098209171 group by v40)
select movie_id as v40, keyword_id as v23 from movie_keyword as mk, aggView1872189775503809281 where mk.movie_id=aggView1872189775503809281.v40);
create or replace view aggJoin1850442494296691248 as (
with aggView5753009846926365266 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView5753009846926365266 where cc.status_id=aggView5753009846926365266.v7);
create or replace view aggJoin3637928608765539708 as (
with aggView3545330434930956977 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin1850442494296691248 join aggView3545330434930956977 using(v5));
create or replace view aggJoin1052634371829317652 as (
with aggView5960327908371632696 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40 from aggJoin4174212229482086564 join aggView5960327908371632696 using(v23));
create or replace view aggJoin6123157774344419581 as (
with aggView1350884601978075757 as (select v40 from aggJoin1052634371829317652 group by v40)
select v40 from aggJoin3637928608765539708 join aggView1350884601978075757 using(v40));
create or replace view aggJoin3607907746080152083 as (
with aggView8975559730903146022 as (select v40 from aggJoin6123157774344419581 group by v40)
select v41, v44 from aggJoin3067249434787428567 join aggView8975559730903146022 using(v40));
create or replace view aggView1706846325375956220 as select v41 from aggJoin3607907746080152083 group by v41;
select MIN(v41) as v52 from aggView1706846325375956220;
