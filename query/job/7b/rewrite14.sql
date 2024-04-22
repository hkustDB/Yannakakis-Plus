create or replace view aggJoin7997641450650391634 as (
with aggView5141905337212568374 as (select id as v24, name as v50 from name as n where gender= 'm' and name_pcode_cf LIKE 'D%')
select person_id as v24, movie_id as v38, v50 from cast_info as ci, aggView5141905337212568374 where ci.person_id=aggView5141905337212568374.v24);
create or replace view aggJoin4888093618845403964 as (
with aggView7370799655752996255 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView7370799655752996255 where pi.info_type_id=aggView7370799655752996255.v16 and note= 'Volker Boehm');
create or replace view aggJoin8234588905396917318 as (
with aggView8674927406586141093 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView8674927406586141093 where ml.link_type_id=aggView8674927406586141093.v18);
create or replace view aggJoin7050828363069060516 as (
with aggView6409233987581486188 as (select v38 from aggJoin8234588905396917318 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView6409233987581486188 where t.id=aggView6409233987581486188.v38 and production_year<=1984 and production_year>=1980);
create or replace view aggJoin8080376549583122613 as (
with aggView6521551761667004614 as (select v38, MIN(v39) as v51 from aggJoin7050828363069060516 group by v38)
select v24, v50 as v50, v51 from aggJoin7997641450650391634 join aggView6521551761667004614 using(v38));
create or replace view aggJoin6623775305148434025 as (
with aggView5909087015266805901 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select v24, v37 from aggJoin4888093618845403964 join aggView5909087015266805901 using(v24));
create or replace view aggJoin895805396334787221 as (
with aggView3889737234019769637 as (select v24 from aggJoin6623775305148434025 group by v24)
select v50 as v50, v51 as v51 from aggJoin8080376549583122613 join aggView3889737234019769637 using(v24));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin895805396334787221;
