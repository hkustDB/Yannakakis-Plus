create or replace view aggJoin668057448638411274 as (
with aggView6411699367696791715 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select person_id as v24, info_type_id as v16, note as v37 from person_info as pi, aggView6411699367696791715 where pi.person_id=aggView6411699367696791715.v24 and note= 'Volker Boehm');
create or replace view aggJoin210644526479170001 as (
with aggView5303306681947659283 as (select id as v16 from info_type as it where info= 'mini biography')
select v24, v37 from aggJoin668057448638411274 join aggView5303306681947659283 using(v16));
create or replace view aggJoin4038164408326866941 as (
with aggView832239277810283210 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView832239277810283210 where ml.link_type_id=aggView832239277810283210.v18);
create or replace view aggJoin4473392155496483070 as (
with aggView542939549766196783 as (select v24 from aggJoin210644526479170001 group by v24)
select id as v24, name as v25, name_pcode_cf as v29 from name as n, aggView542939549766196783 where n.id=aggView542939549766196783.v24 and name_pcode_cf>='A' and name LIKE 'B%' and name_pcode_cf<='F');
create or replace view aggJoin5198912143085566523 as (
with aggView972492731073315242 as (select v24, MIN(v25) as v50 from aggJoin4473392155496483070 group by v24)
select movie_id as v38, v50 from cast_info as ci, aggView972492731073315242 where ci.person_id=aggView972492731073315242.v24);
create or replace view aggJoin2747873206027438234 as (
with aggView3026912904532363942 as (select v38 from aggJoin4038164408326866941 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView3026912904532363942 where t.id=aggView3026912904532363942.v38 and production_year>=1980 and production_year<=1995);
create or replace view aggJoin3521384703611011109 as (
with aggView3396939417824026424 as (select v38, MIN(v39) as v51 from aggJoin2747873206027438234 group by v38)
select v50 as v50, v51 from aggJoin5198912143085566523 join aggView3396939417824026424 using(v38));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin3521384703611011109;
