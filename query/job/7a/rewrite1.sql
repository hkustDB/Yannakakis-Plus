create or replace view aggJoin1273990241821541559 as (
with aggView4146170243826319442 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select id as v24, name as v25, name_pcode_cf as v29 from name as n, aggView4146170243826319442 where n.id=aggView4146170243826319442.v24 and name_pcode_cf>='A' and name LIKE 'B%' and name_pcode_cf<='F');
create or replace view aggJoin8533785225438967086 as (
with aggView8482080266510430881 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView8482080266510430881 where pi.info_type_id=aggView8482080266510430881.v16 and note= 'Volker Boehm');
create or replace view aggJoin2632627660413922445 as (
with aggView6858862584685622385 as (select v24 from aggJoin8533785225438967086 group by v24)
select v24, v25, v29 from aggJoin1273990241821541559 join aggView6858862584685622385 using(v24));
create or replace view aggView870646062107019803 as select v25, v24 from aggJoin2632627660413922445 group by v25,v24;
create or replace view aggJoin310951043216269511 as (
with aggView8047426272370209994 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView8047426272370209994 where ml.link_type_id=aggView8047426272370209994.v18);
create or replace view aggJoin7174776592261814447 as (
with aggView4576055481639746301 as (select v38 from aggJoin310951043216269511 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView4576055481639746301 where t.id=aggView4576055481639746301.v38 and production_year>=1980 and production_year<=1995);
create or replace view aggView1210988582425223533 as select v39, v38 from aggJoin7174776592261814447 group by v39,v38;
create or replace view aggJoin6020473643920466512 as (
with aggView7019065646196766007 as (select v24, MIN(v25) as v50 from aggView870646062107019803 group by v24)
select movie_id as v38, v50 from cast_info as ci, aggView7019065646196766007 where ci.person_id=aggView7019065646196766007.v24);
create or replace view aggJoin6156857355511205462 as (
with aggView2470804070415368447 as (select v38, MIN(v50) as v50 from aggJoin6020473643920466512 group by v38,v50)
select v39, v50 from aggView1210988582425223533 join aggView2470804070415368447 using(v38));
select MIN(v50) as v50,MIN(v39) as v51 from aggJoin6156857355511205462;
