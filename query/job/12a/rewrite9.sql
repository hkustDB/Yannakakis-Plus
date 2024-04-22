create or replace view aggView479979750875415544 as select title as v30, id as v29 from title as t where production_year<=2008 and production_year>=2005;
create or replace view aggView1185743752318374040 as select name as v2, id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin3697096897379154071 as (
with aggView5303497202397947497 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView5303497202397947497 where mi_idx.info_type_id=aggView5303497202397947497.v26);
create or replace view aggJoin9028900732578299967 as (
with aggView5912776850647620018 as (select v27, v29 from aggJoin3697096897379154071 group by v27,v29)
select v29, v27 from aggView5912776850647620018 where v27>'8.0');
create or replace view aggJoin2841973657900420077 as (
with aggView8613258435957322998 as (select v1, MIN(v2) as v41 from aggView1185743752318374040 group by v1)
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView8613258435957322998 where mc.company_id=aggView8613258435957322998.v1);
create or replace view aggJoin151875745856060053 as (
with aggView5016654381381714294 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView5016654381381714294 where mi.info_type_id=aggView5016654381381714294.v21 and info IN ('Drama','Horror'));
create or replace view aggJoin4380557215944501921 as (
with aggView6041141539665234747 as (select v29 from aggJoin151875745856060053 group by v29)
select v29, v8, v41 as v41 from aggJoin2841973657900420077 join aggView6041141539665234747 using(v29));
create or replace view aggJoin9144690660735042603 as (
with aggView439423490002981552 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin4380557215944501921 join aggView439423490002981552 using(v8));
create or replace view aggJoin3847530306182881907 as (
with aggView1546278919467432498 as (select v29, MIN(v41) as v41 from aggJoin9144690660735042603 group by v29,v41)
select v30, v29, v41 from aggView479979750875415544 join aggView1546278919467432498 using(v29));
create or replace view aggJoin8738466859819298711 as (
with aggView2782376355820715715 as (select v29, MIN(v41) as v41, MIN(v30) as v43 from aggJoin3847530306182881907 group by v29,v41)
select v27, v41, v43 from aggJoin9028900732578299967 join aggView2782376355820715715 using(v29));
select MIN(v41) as v41,MIN(v27) as v42,MIN(v43) as v43 from aggJoin8738466859819298711;
