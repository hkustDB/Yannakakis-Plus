create or replace view aggView6746732572611689432 as select title as v39, id as v38 from title as t where production_year>=1980 and production_year<=1995;
create or replace view aggView520589488148865762 as select name as v25, id as v24 from name as n where name_pcode_cf>='A' and name LIKE 'B%' and name_pcode_cf<='F';
create or replace view aggJoin3574769905415789120 as (
with aggView7985090097665966147 as (select v38, MIN(v39) as v51 from aggView6746732572611689432 group by v38)
select person_id as v24, movie_id as v38, v51 from cast_info as ci, aggView7985090097665966147 where ci.movie_id=aggView7985090097665966147.v38);
create or replace view aggJoin3352730679886646273 as (
with aggView2304805027306179182 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select person_id as v24, info_type_id as v16, note as v37 from person_info as pi, aggView2304805027306179182 where pi.person_id=aggView2304805027306179182.v24 and note= 'Volker Boehm');
create or replace view aggJoin2302058064692607022 as (
with aggView8724735938285235887 as (select id as v16 from info_type as it where info= 'mini biography')
select v24, v37 from aggJoin3352730679886646273 join aggView8724735938285235887 using(v16));
create or replace view aggJoin8885998494342401179 as (
with aggView1286410664164923464 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView1286410664164923464 where ml.link_type_id=aggView1286410664164923464.v18);
create or replace view aggJoin8349350903843424915 as (
with aggView4882910772089145141 as (select v38 from aggJoin8885998494342401179 group by v38)
select v24, v51 as v51 from aggJoin3574769905415789120 join aggView4882910772089145141 using(v38));
create or replace view aggJoin1916251520522402787 as (
with aggView8863575360273271007 as (select v24 from aggJoin2302058064692607022 group by v24)
select v24, v51 as v51 from aggJoin8349350903843424915 join aggView8863575360273271007 using(v24));
create or replace view aggJoin3076420299266311654 as (
with aggView4655231167758806213 as (select v24, MIN(v51) as v51 from aggJoin1916251520522402787 group by v24,v51)
select v25, v51 from aggView520589488148865762 join aggView4655231167758806213 using(v24));
select MIN(v25) as v50,MIN(v51) as v51 from aggJoin3076420299266311654;
