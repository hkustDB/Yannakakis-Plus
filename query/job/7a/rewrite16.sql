create or replace view aggJoin7469576537637343297 as (
with aggView7662436674662244799 as (select id as v24, name as v50 from name as n where name_pcode_cf>='A' and name LIKE 'B%' and name_pcode_cf<='F')
select person_id as v24, info_type_id as v16, note as v37, v50 from person_info as pi, aggView7662436674662244799 where pi.person_id=aggView7662436674662244799.v24 and note= 'Volker Boehm');
create or replace view aggJoin1459827795067089173 as (
with aggView8389049295499212807 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select v24, v16, v37, v50 as v50 from aggJoin7469576537637343297 join aggView8389049295499212807 using(v24));
create or replace view aggJoin3516720224231174741 as (
with aggView6462720009658638047 as (select id as v16 from info_type as it where info= 'mini biography')
select v24, v37, v50 from aggJoin1459827795067089173 join aggView6462720009658638047 using(v16));
create or replace view aggJoin9041382193837284564 as (
with aggView3579477705766120989 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView3579477705766120989 where ml.link_type_id=aggView3579477705766120989.v18);
create or replace view aggJoin4598071747783957477 as (
with aggView4510318207619298078 as (select v38 from aggJoin9041382193837284564 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView4510318207619298078 where t.id=aggView4510318207619298078.v38 and production_year>=1980 and production_year<=1995);
create or replace view aggJoin8472297062085071308 as (
with aggView6262258538066247123 as (select v38, MIN(v39) as v51 from aggJoin4598071747783957477 group by v38)
select person_id as v24, v51 from cast_info as ci, aggView6262258538066247123 where ci.movie_id=aggView6262258538066247123.v38);
create or replace view aggJoin7029640037331903871 as (
with aggView1016112891447815392 as (select v24, MIN(v50) as v50 from aggJoin3516720224231174741 group by v24,v50)
select v51 as v51, v50 from aggJoin8472297062085071308 join aggView1016112891447815392 using(v24));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin7029640037331903871;
