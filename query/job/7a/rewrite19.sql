create or replace view aggJoin4610657939751339395 as (
with aggView6320686129263436069 as (select id as v24, name as v50 from name as n where name_pcode_cf>='A' and name LIKE 'B%' and name_pcode_cf<='F')
select person_id as v24, movie_id as v38, v50 from cast_info as ci, aggView6320686129263436069 where ci.person_id=aggView6320686129263436069.v24);
create or replace view aggJoin6337726314647046605 as (
with aggView8377683548716325883 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select v24, v38, v50 as v50 from aggJoin4610657939751339395 join aggView8377683548716325883 using(v24));
create or replace view aggJoin6443056023827116503 as (
with aggView5473419708375269140 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView5473419708375269140 where pi.info_type_id=aggView5473419708375269140.v16 and note= 'Volker Boehm');
create or replace view aggJoin7059850635456629965 as (
with aggView4015511739039408326 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView4015511739039408326 where ml.link_type_id=aggView4015511739039408326.v18);
create or replace view aggJoin5338561952861802136 as (
with aggView3385257044831499393 as (select v38 from aggJoin7059850635456629965 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView3385257044831499393 where t.id=aggView3385257044831499393.v38 and production_year>=1980 and production_year<=1995);
create or replace view aggJoin4585322884038530245 as (
with aggView2913628717581467230 as (select v38, MIN(v39) as v51 from aggJoin5338561952861802136 group by v38)
select v24, v50 as v50, v51 from aggJoin6337726314647046605 join aggView2913628717581467230 using(v38));
create or replace view aggJoin5233834160585212195 as (
with aggView3814226682689399980 as (select v24 from aggJoin6443056023827116503 group by v24)
select v50 as v50, v51 as v51 from aggJoin4585322884038530245 join aggView3814226682689399980 using(v24));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin5233834160585212195;
