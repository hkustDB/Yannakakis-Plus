create or replace view aggView6447499723063009437 as select name as v25, id as v24 from name as n where gender= 'm' and name_pcode_cf LIKE 'D%';
create or replace view aggJoin9028392661093862670 as (
with aggView3044013479431439670 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView3044013479431439670 where ml.link_type_id=aggView3044013479431439670.v18);
create or replace view aggJoin3229623521945725355 as (
with aggView4142864527346668781 as (select v38 from aggJoin9028392661093862670 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView4142864527346668781 where t.id=aggView4142864527346668781.v38 and production_year<=1984 and production_year>=1980);
create or replace view aggView5561508059556301437 as select v38, v39 from aggJoin3229623521945725355 group by v38,v39;
create or replace view aggJoin1180662210270792051 as (
with aggView8846794382260314992 as (select v24, MIN(v25) as v50 from aggView6447499723063009437 group by v24)
select person_id as v24, movie_id as v38, v50 from cast_info as ci, aggView8846794382260314992 where ci.person_id=aggView8846794382260314992.v24);
create or replace view aggJoin2401247757858464045 as (
with aggView9145737974357065242 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView9145737974357065242 where pi.info_type_id=aggView9145737974357065242.v16 and note= 'Volker Boehm');
create or replace view aggJoin9187292352155318465 as (
with aggView8131353249244408551 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select v24, v37 from aggJoin2401247757858464045 join aggView8131353249244408551 using(v24));
create or replace view aggJoin4573173533896169154 as (
with aggView3131516932085923244 as (select v24 from aggJoin9187292352155318465 group by v24)
select v38, v50 as v50 from aggJoin1180662210270792051 join aggView3131516932085923244 using(v24));
create or replace view aggJoin5984762843345903500 as (
with aggView4385225455786395569 as (select v38, MIN(v50) as v50 from aggJoin4573173533896169154 group by v38,v50)
select v39, v50 from aggView5561508059556301437 join aggView4385225455786395569 using(v38));
select MIN(v50) as v50,MIN(v39) as v51 from aggJoin5984762843345903500;
