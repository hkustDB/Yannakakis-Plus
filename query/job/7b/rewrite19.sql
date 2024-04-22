create or replace view aggJoin4216237609145653431 as (
with aggView5985770376089784905 as (select id as v24, name as v50 from name as n where gender= 'm' and name_pcode_cf LIKE 'D%')
select person_id as v24, movie_id as v38, v50 from cast_info as ci, aggView5985770376089784905 where ci.person_id=aggView5985770376089784905.v24);
create or replace view aggJoin3900109661989489159 as (
with aggView4465704256125805040 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select v24, v38, v50 as v50 from aggJoin4216237609145653431 join aggView4465704256125805040 using(v24));
create or replace view aggJoin7211271079139894980 as (
with aggView2290619950346100927 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView2290619950346100927 where pi.info_type_id=aggView2290619950346100927.v16 and note= 'Volker Boehm');
create or replace view aggJoin7013864913100835651 as (
with aggView8266326464483541748 as (select v24 from aggJoin7211271079139894980 group by v24)
select v38, v50 as v50 from aggJoin3900109661989489159 join aggView8266326464483541748 using(v24));
create or replace view aggJoin3053920384848343161 as (
with aggView2481260844761997081 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView2481260844761997081 where ml.link_type_id=aggView2481260844761997081.v18);
create or replace view aggJoin4837422017993088197 as (
with aggView4970587659788720512 as (select v38 from aggJoin3053920384848343161 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView4970587659788720512 where t.id=aggView4970587659788720512.v38 and production_year<=1984 and production_year>=1980);
create or replace view aggJoin2700709943044429021 as (
with aggView5110228983042040108 as (select v38, MIN(v39) as v51 from aggJoin4837422017993088197 group by v38)
select v50 as v50, v51 from aggJoin7013864913100835651 join aggView5110228983042040108 using(v38));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin2700709943044429021;
