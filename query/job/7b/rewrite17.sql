create or replace view aggJoin7254055237013759347 as (
with aggView2244145019040636722 as (select id as v24, name as v50 from name as n where gender= 'm' and name_pcode_cf LIKE 'D%')
select person_id as v24, info_type_id as v16, note as v37, v50 from person_info as pi, aggView2244145019040636722 where pi.person_id=aggView2244145019040636722.v24 and note= 'Volker Boehm');
create or replace view aggJoin7432188328781826911 as (
with aggView8326303483272907378 as (select id as v38, title as v51 from title as t where production_year<=1984 and production_year>=1980)
select person_id as v24, movie_id as v38, v51 from cast_info as ci, aggView8326303483272907378 where ci.movie_id=aggView8326303483272907378.v38);
create or replace view aggJoin8062586222643347484 as (
with aggView9032587209238210237 as (select id as v16 from info_type as it where info= 'mini biography')
select v24, v37, v50 from aggJoin7254055237013759347 join aggView9032587209238210237 using(v16));
create or replace view aggJoin2715186880686862711 as (
with aggView123815002742295977 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView123815002742295977 where ml.link_type_id=aggView123815002742295977.v18);
create or replace view aggJoin5796335634796028838 as (
with aggView7111860428232389559 as (select v38 from aggJoin2715186880686862711 group by v38)
select v24, v51 as v51 from aggJoin7432188328781826911 join aggView7111860428232389559 using(v38));
create or replace view aggJoin3276244481760286631 as (
with aggView1663085195877347509 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select v24, v37, v50 as v50 from aggJoin8062586222643347484 join aggView1663085195877347509 using(v24));
create or replace view aggJoin6986588873452538563 as (
with aggView1212998976006300289 as (select v24, MIN(v50) as v50 from aggJoin3276244481760286631 group by v24,v50)
select v51 as v51, v50 from aggJoin5796335634796028838 join aggView1212998976006300289 using(v24));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin6986588873452538563;
