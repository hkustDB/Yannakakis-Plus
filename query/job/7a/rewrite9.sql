create or replace view aggJoin7410916085015115724 as (
with aggView2878984253344487372 as (select id as v38, title as v51 from title as t where production_year>=1980 and production_year<=1995)
select linked_movie_id as v38, link_type_id as v18, v51 from movie_link as ml, aggView2878984253344487372 where ml.linked_movie_id=aggView2878984253344487372.v38);
create or replace view aggJoin6904003310156572454 as (
with aggView1351867465017616787 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select person_id as v24, info_type_id as v16, note as v37 from person_info as pi, aggView1351867465017616787 where pi.person_id=aggView1351867465017616787.v24 and note= 'Volker Boehm');
create or replace view aggJoin2741869341776573446 as (
with aggView1224240929195265275 as (select id as v16 from info_type as it where info= 'mini biography')
select v24, v37 from aggJoin6904003310156572454 join aggView1224240929195265275 using(v16));
create or replace view aggJoin3020887423992303442 as (
with aggView5397674501853036879 as (select id as v18 from link_type as lt where link= 'features')
select v38, v51 from aggJoin7410916085015115724 join aggView5397674501853036879 using(v18));
create or replace view aggJoin9064708877214264550 as (
with aggView9018979041424279179 as (select v38, MIN(v51) as v51 from aggJoin3020887423992303442 group by v38,v51)
select person_id as v24, v51 from cast_info as ci, aggView9018979041424279179 where ci.movie_id=aggView9018979041424279179.v38);
create or replace view aggJoin2484134770025292588 as (
with aggView8831417390826316503 as (select v24 from aggJoin2741869341776573446 group by v24)
select id as v24, name as v25, name_pcode_cf as v29 from name as n, aggView8831417390826316503 where n.id=aggView8831417390826316503.v24 and name_pcode_cf>='A' and name LIKE 'B%' and name_pcode_cf<='F');
create or replace view aggJoin6629417439634964248 as (
with aggView2651645245180234143 as (select v24, MIN(v25) as v50 from aggJoin2484134770025292588 group by v24)
select v51 as v51, v50 from aggJoin9064708877214264550 join aggView2651645245180234143 using(v24));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin6629417439634964248;
