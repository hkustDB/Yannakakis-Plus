create or replace view aggJoin7336004356162250745 as (
with aggView1662194456516550441 as (select id as v38, title as v51 from title as t where production_year>=1980 and production_year<=1995)
select linked_movie_id as v38, link_type_id as v18, v51 from movie_link as ml, aggView1662194456516550441 where ml.linked_movie_id=aggView1662194456516550441.v38);
create or replace view aggJoin4489006787390936138 as (
with aggView2132682083657106282 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select person_id as v24, movie_id as v38 from cast_info as ci, aggView2132682083657106282 where ci.person_id=aggView2132682083657106282.v24);
create or replace view aggJoin2043488970679508187 as (
with aggView57559597373902822 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView57559597373902822 where pi.info_type_id=aggView57559597373902822.v16 and note= 'Volker Boehm');
create or replace view aggJoin785535957328924523 as (
with aggView694626824211406969 as (select id as v18 from link_type as lt where link= 'features')
select v38, v51 from aggJoin7336004356162250745 join aggView694626824211406969 using(v18));
create or replace view aggJoin7033332392388181046 as (
with aggView8091174106059761919 as (select v38, MIN(v51) as v51 from aggJoin785535957328924523 group by v38,v51)
select v24, v51 from aggJoin4489006787390936138 join aggView8091174106059761919 using(v38));
create or replace view aggJoin2854897281092162909 as (
with aggView3208574172853087050 as (select v24 from aggJoin2043488970679508187 group by v24)
select id as v24, name as v25, name_pcode_cf as v29 from name as n, aggView3208574172853087050 where n.id=aggView3208574172853087050.v24 and name_pcode_cf>='A' and name LIKE 'B%' and name_pcode_cf<='F');
create or replace view aggJoin1632017617303403547 as (
with aggView3319586963703609922 as (select v24, MIN(v25) as v50 from aggJoin2854897281092162909 group by v24)
select v51 as v51, v50 from aggJoin7033332392388181046 join aggView3319586963703609922 using(v24));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin1632017617303403547;
