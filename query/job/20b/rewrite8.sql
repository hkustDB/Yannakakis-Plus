create or replace view aggJoin5949090464431835759 as (
with aggView8713941266194968284 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView8713941266194968284 where t.kind_id=aggView8713941266194968284.v26 and production_year>2000);
create or replace view aggJoin3231691329439071861 as (
with aggView7677600926307575357 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select person_id as v31, movie_id as v40 from cast_info as ci, aggView7677600926307575357 where ci.person_role_id=aggView7677600926307575357.v9);
create or replace view aggJoin5364811563180524831 as (
with aggView2465418885841917581 as (select id as v31 from name as n where name LIKE '%Downey%Robert%')
select v40 from aggJoin3231691329439071861 join aggView2465418885841917581 using(v31));
create or replace view aggJoin1115733264862589993 as (
with aggView8986694094056040930 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView8986694094056040930 where cc.status_id=aggView8986694094056040930.v7);
create or replace view aggJoin422851881780901131 as (
with aggView6721032474076107094 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin1115733264862589993 join aggView6721032474076107094 using(v5));
create or replace view aggJoin1430834872558734627 as (
with aggView3321008207365552793 as (select v40 from aggJoin422851881780901131 group by v40)
select movie_id as v40, keyword_id as v23 from movie_keyword as mk, aggView3321008207365552793 where mk.movie_id=aggView3321008207365552793.v40);
create or replace view aggJoin7418955259371657958 as (
with aggView236936818247755981 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40 from aggJoin1430834872558734627 join aggView236936818247755981 using(v23));
create or replace view aggJoin5329903695595995478 as (
with aggView5778077085992060365 as (select v40 from aggJoin7418955259371657958 group by v40)
select v40 from aggJoin5364811563180524831 join aggView5778077085992060365 using(v40));
create or replace view aggJoin6081439489580381454 as (
with aggView6608603809514398207 as (select v40 from aggJoin5329903695595995478 group by v40)
select v41, v44 from aggJoin5949090464431835759 join aggView6608603809514398207 using(v40));
create or replace view aggView732838646119559331 as select v41 from aggJoin6081439489580381454 group by v41;
select MIN(v41) as v52 from aggView732838646119559331;
