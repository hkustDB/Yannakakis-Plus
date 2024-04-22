create or replace view aggJoin5366442018398639623 as (
with aggView6423330098961337604 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, info as v36 from person_info as pi, aggView6423330098961337604 where pi.info_type_id=aggView6423330098961337604.v16);
create or replace view aggJoin6197215833072546799 as (
with aggView6120160421175098344 as (select v24, MIN(v36) as v51 from aggJoin5366442018398639623 group by v24)
select person_id as v24, movie_id as v38, v51 from cast_info as ci, aggView6120160421175098344 where ci.person_id=aggView6120160421175098344.v24);
create or replace view aggJoin9207063685016284708 as (
with aggView3573619716632846903 as (select id as v18 from link_type as lt where link IN ('references','referenced in','features','featured in'))
select linked_movie_id as v38 from movie_link as ml, aggView3573619716632846903 where ml.link_type_id=aggView3573619716632846903.v18);
create or replace view aggJoin214656166026147318 as (
with aggView6879338053859617689 as (select v38 from aggJoin9207063685016284708 group by v38)
select id as v38, production_year as v42 from title as t, aggView6879338053859617689 where t.id=aggView6879338053859617689.v38 and production_year<=2010 and production_year>=1980);
create or replace view aggJoin2991115039694100120 as (
with aggView4748315365588602165 as (select v38 from aggJoin214656166026147318 group by v38)
select v24, v51 as v51 from aggJoin6197215833072546799 join aggView4748315365588602165 using(v38));
create or replace view aggJoin4629334007280934118 as (
with aggView4855277403968544631 as (select person_id as v24 from aka_name as an where ((name LIKE '%a%') OR (name LIKE 'A%')) group by person_id)
select id as v24, name as v25, name_pcode_cf as v29 from name as n, aggView4855277403968544631 where n.id=aggView4855277403968544631.v24 and name LIKE 'A%' and name_pcode_cf>='A' and name_pcode_cf<='F');
create or replace view aggJoin1957474061508810980 as (
with aggView5667781831855861922 as (select v24, MIN(v25) as v50 from aggJoin4629334007280934118 group by v24)
select v51 as v51, v50 from aggJoin2991115039694100120 join aggView5667781831855861922 using(v24));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin1957474061508810980;
