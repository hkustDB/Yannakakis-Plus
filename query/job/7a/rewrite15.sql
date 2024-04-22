create or replace view aggJoin5338680576980601691 as (
with aggView7664732912471198511 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select id as v24, name as v25, name_pcode_cf as v29 from name as n, aggView7664732912471198511 where n.id=aggView7664732912471198511.v24 and name_pcode_cf>='A' and name LIKE 'B%' and name_pcode_cf<='F');
create or replace view aggJoin2664423345875027116 as (
with aggView3621232404205024925 as (select v24, MIN(v25) as v50 from aggJoin5338680576980601691 group by v24)
select person_id as v24, movie_id as v38, v50 from cast_info as ci, aggView3621232404205024925 where ci.person_id=aggView3621232404205024925.v24);
create or replace view aggJoin7190758962567145763 as (
with aggView2203301597529172456 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView2203301597529172456 where pi.info_type_id=aggView2203301597529172456.v16 and note= 'Volker Boehm');
create or replace view aggJoin7113877828116385351 as (
with aggView8162513745222119739 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView8162513745222119739 where ml.link_type_id=aggView8162513745222119739.v18);
create or replace view aggJoin3550142463314578857 as (
with aggView7602762348045604271 as (select v38 from aggJoin7113877828116385351 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView7602762348045604271 where t.id=aggView7602762348045604271.v38 and production_year>=1980 and production_year<=1995);
create or replace view aggJoin5985658215445903258 as (
with aggView6821280447105113672 as (select v38, MIN(v39) as v51 from aggJoin3550142463314578857 group by v38)
select v24, v50 as v50, v51 from aggJoin2664423345875027116 join aggView6821280447105113672 using(v38));
create or replace view aggJoin2797464899884869488 as (
with aggView4925575475202759000 as (select v24 from aggJoin7190758962567145763 group by v24)
select v50 as v50, v51 as v51 from aggJoin5985658215445903258 join aggView4925575475202759000 using(v24));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin2797464899884869488;
