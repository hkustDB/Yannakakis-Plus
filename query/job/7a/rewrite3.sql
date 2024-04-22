create or replace view aggJoin2099719146536631983 as (
with aggView7182037768220094241 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select id as v24, name as v25, name_pcode_cf as v29 from name as n, aggView7182037768220094241 where n.id=aggView7182037768220094241.v24 and name_pcode_cf>='A' and name LIKE 'B%' and name_pcode_cf<='F');
create or replace view aggJoin5919480329686582635 as (
with aggView5371325382705602761 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView5371325382705602761 where pi.info_type_id=aggView5371325382705602761.v16 and note= 'Volker Boehm');
create or replace view aggJoin8939517293113141232 as (
with aggView8986301696398450900 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView8986301696398450900 where ml.link_type_id=aggView8986301696398450900.v18);
create or replace view aggJoin667199020954157096 as (
with aggView8858742339134808019 as (select v24 from aggJoin5919480329686582635 group by v24)
select v24, v25, v29 from aggJoin2099719146536631983 join aggView8858742339134808019 using(v24));
create or replace view aggView1607156712070431808 as select v25, v24 from aggJoin667199020954157096 group by v25,v24;
create or replace view aggJoin1130619642331002226 as (
with aggView1760554719586570542 as (select v38 from aggJoin8939517293113141232 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView1760554719586570542 where t.id=aggView1760554719586570542.v38 and production_year>=1980 and production_year<=1995);
create or replace view aggView764947320451606055 as select v39, v38 from aggJoin1130619642331002226 group by v39,v38;
create or replace view aggJoin7107603761182979462 as (
with aggView922555489226381608 as (select v38, MIN(v39) as v51 from aggView764947320451606055 group by v38)
select person_id as v24, v51 from cast_info as ci, aggView922555489226381608 where ci.movie_id=aggView922555489226381608.v38);
create or replace view aggJoin1299537266292095814 as (
with aggView5308104126648637460 as (select v24, MIN(v51) as v51 from aggJoin7107603761182979462 group by v24,v51)
select v25, v51 from aggView1607156712070431808 join aggView5308104126648637460 using(v24));
select MIN(v25) as v50,MIN(v51) as v51 from aggJoin1299537266292095814;
