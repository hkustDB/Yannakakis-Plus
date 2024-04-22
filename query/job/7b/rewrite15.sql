create or replace view aggJoin8096827468786521827 as (
with aggView3968310335303578192 as (select id as v38, title as v51 from title as t where production_year<=1984 and production_year>=1980)
select person_id as v24, movie_id as v38, v51 from cast_info as ci, aggView3968310335303578192 where ci.movie_id=aggView3968310335303578192.v38);
create or replace view aggJoin6411329278374273654 as (
with aggView5834642022692889890 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView5834642022692889890 where pi.info_type_id=aggView5834642022692889890.v16 and note= 'Volker Boehm');
create or replace view aggJoin5023049137688886412 as (
with aggView8007460834857122028 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView8007460834857122028 where ml.link_type_id=aggView8007460834857122028.v18);
create or replace view aggJoin3817052544463828087 as (
with aggView3472299707726318412 as (select v38 from aggJoin5023049137688886412 group by v38)
select v24, v51 as v51 from aggJoin8096827468786521827 join aggView3472299707726318412 using(v38));
create or replace view aggJoin2729332392832496626 as (
with aggView3575892527255620952 as (select v24 from aggJoin6411329278374273654 group by v24)
select person_id as v24, name as v3 from aka_name as an, aggView3575892527255620952 where an.person_id=aggView3575892527255620952.v24 and name LIKE '%a%');
create or replace view aggJoin6338081600907914725 as (
with aggView8796645612263383527 as (select v24 from aggJoin2729332392832496626 group by v24)
select id as v24, name as v25, gender as v28, name_pcode_cf as v29 from name as n, aggView8796645612263383527 where n.id=aggView8796645612263383527.v24 and gender= 'm' and name_pcode_cf LIKE 'D%');
create or replace view aggJoin8775389043621027634 as (
with aggView3044220968413708574 as (select v24, MIN(v25) as v50 from aggJoin6338081600907914725 group by v24)
select v51 as v51, v50 from aggJoin3817052544463828087 join aggView3044220968413708574 using(v24));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin8775389043621027634;
