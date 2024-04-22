create or replace view aggView3479630782022482862 as select name as v25, id as v24 from name as n where name LIKE 'A%' and name_pcode_cf>='A' and name_pcode_cf<='F';
create or replace view aggJoin1658990744611256312 as (
with aggView5248717394364238845 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, info as v36 from person_info as pi, aggView5248717394364238845 where pi.info_type_id=aggView5248717394364238845.v16);
create or replace view aggJoin571899643607677342 as (
with aggView3434152586385295497 as (select id as v38 from title as t where production_year<=2010 and production_year>=1980)
select linked_movie_id as v38, link_type_id as v18 from movie_link as ml, aggView3434152586385295497 where ml.linked_movie_id=aggView3434152586385295497.v38);
create or replace view aggJoin5776982216812854250 as (
with aggView5344867053003434135 as (select id as v18 from link_type as lt where link IN ('references','referenced in','features','featured in'))
select v38 from aggJoin571899643607677342 join aggView5344867053003434135 using(v18));
create or replace view aggJoin7834835172034095000 as (
with aggView1249032853004308574 as (select person_id as v24 from aka_name as an where ((name LIKE '%a%') OR (name LIKE 'A%')) group by person_id)
select person_id as v24, movie_id as v38 from cast_info as ci, aggView1249032853004308574 where ci.person_id=aggView1249032853004308574.v24);
create or replace view aggJoin446273953105687034 as (
with aggView9040359414831090733 as (select v38 from aggJoin5776982216812854250 group by v38)
select v24 from aggJoin7834835172034095000 join aggView9040359414831090733 using(v38));
create or replace view aggJoin6948735817334717640 as (
with aggView6592131827713346008 as (select v24 from aggJoin446273953105687034 group by v24)
select v24, v36 from aggJoin1658990744611256312 join aggView6592131827713346008 using(v24));
create or replace view aggView3520119222730067536 as select v24, v36 from aggJoin6948735817334717640 group by v24,v36;
create or replace view aggJoin7098510877337476746 as (
with aggView1093355463726496017 as (select v24, MIN(v25) as v50 from aggView3479630782022482862 group by v24)
select v36, v50 from aggView3520119222730067536 join aggView1093355463726496017 using(v24));
select MIN(v50) as v50,MIN(v36) as v51 from aggJoin7098510877337476746;
