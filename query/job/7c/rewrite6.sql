create or replace view aggJoin1804072071538419956 as (
with aggView2541069606866417226 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, info as v36 from person_info as pi, aggView2541069606866417226 where pi.info_type_id=aggView2541069606866417226.v16);
create or replace view aggJoin6771048190921787947 as (
with aggView1222470709748354874 as (select id as v38 from title as t where production_year<=2010 and production_year>=1980)
select linked_movie_id as v38, link_type_id as v18 from movie_link as ml, aggView1222470709748354874 where ml.linked_movie_id=aggView1222470709748354874.v38);
create or replace view aggJoin3275227270044708078 as (
with aggView8006070742434695734 as (select id as v18 from link_type as lt where link IN ('references','referenced in','features','featured in'))
select v38 from aggJoin6771048190921787947 join aggView8006070742434695734 using(v18));
create or replace view aggJoin6967995846141069816 as (
with aggView6922182518253755843 as (select v38 from aggJoin3275227270044708078 group by v38)
select person_id as v24 from cast_info as ci, aggView6922182518253755843 where ci.movie_id=aggView6922182518253755843.v38);
create or replace view aggJoin3548312699308334166 as (
with aggView4306396442306943004 as (select v24 from aggJoin6967995846141069816 group by v24)
select v24, v36 from aggJoin1804072071538419956 join aggView4306396442306943004 using(v24));
create or replace view aggView3183878033253525910 as select v24, v36 from aggJoin3548312699308334166 group by v24,v36;
create or replace view aggJoin3256839145757771080 as (
with aggView2665842384439017386 as (select person_id as v24 from aka_name as an where ((name LIKE '%a%') OR (name LIKE 'A%')) group by person_id)
select id as v24, name as v25, name_pcode_cf as v29 from name as n, aggView2665842384439017386 where n.id=aggView2665842384439017386.v24 and name LIKE 'A%' and name_pcode_cf>='A' and name_pcode_cf<='F');
create or replace view aggView553850860817842373 as select v25, v24 from aggJoin3256839145757771080 group by v25,v24;
create or replace view aggJoin4869115648106688187 as (
with aggView6158790180176068028 as (select v24, MIN(v36) as v51 from aggView3183878033253525910 group by v24)
select v25, v51 from aggView553850860817842373 join aggView6158790180176068028 using(v24));
select MIN(v25) as v50,MIN(v51) as v51 from aggJoin4869115648106688187;
