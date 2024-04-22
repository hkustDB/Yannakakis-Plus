create or replace view aggView7378126251215235514 as select id as v38, title as v39 from title as t where production_year<=1984 and production_year>=1980;
create or replace view aggJoin1445572289453213413 as (
with aggView4256166667256483851 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select id as v24, name as v25, gender as v28, name_pcode_cf as v29 from name as n, aggView4256166667256483851 where n.id=aggView4256166667256483851.v24 and gender= 'm' and name_pcode_cf LIKE 'D%');
create or replace view aggView348100577639986211 as select v25, v24 from aggJoin1445572289453213413 group by v25,v24;
create or replace view aggJoin3781590715835263866 as (
with aggView8243317100386503527 as (select v24, MIN(v25) as v50 from aggView348100577639986211 group by v24)
select person_id as v24, movie_id as v38, v50 from cast_info as ci, aggView8243317100386503527 where ci.person_id=aggView8243317100386503527.v24);
create or replace view aggJoin842442932897557449 as (
with aggView1005710482843140114 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView1005710482843140114 where pi.info_type_id=aggView1005710482843140114.v16 and note= 'Volker Boehm');
create or replace view aggJoin92867385278857503 as (
with aggView7489459375080217285 as (select v24 from aggJoin842442932897557449 group by v24)
select v38, v50 as v50 from aggJoin3781590715835263866 join aggView7489459375080217285 using(v24));
create or replace view aggJoin2862758759276251438 as (
with aggView6749246938101288417 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView6749246938101288417 where ml.link_type_id=aggView6749246938101288417.v18);
create or replace view aggJoin2222998805098383045 as (
with aggView4539904928415814422 as (select v38 from aggJoin2862758759276251438 group by v38)
select v38, v50 as v50 from aggJoin92867385278857503 join aggView4539904928415814422 using(v38));
create or replace view aggJoin5005798562268265064 as (
with aggView2525430587360936376 as (select v38, MIN(v50) as v50 from aggJoin2222998805098383045 group by v38,v50)
select v39, v50 from aggView7378126251215235514 join aggView2525430587360936376 using(v38));
select MIN(v50) as v50,MIN(v39) as v51 from aggJoin5005798562268265064;
