create or replace view aggJoin457934428799072477 as (
with aggView3400647502866299209 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select id as v24, name as v25, gender as v28, name_pcode_cf as v29 from name as n, aggView3400647502866299209 where n.id=aggView3400647502866299209.v24 and gender= 'm' and name_pcode_cf LIKE 'D%');
create or replace view aggJoin5586246501003136340 as (
with aggView5338396349750558886 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView5338396349750558886 where pi.info_type_id=aggView5338396349750558886.v16 and note= 'Volker Boehm');
create or replace view aggJoin1918610530277577366 as (
with aggView581359023785381379 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView581359023785381379 where ml.link_type_id=aggView581359023785381379.v18);
create or replace view aggJoin6884401939713761385 as (
with aggView5079444480233519536 as (select v38 from aggJoin1918610530277577366 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView5079444480233519536 where t.id=aggView5079444480233519536.v38 and production_year<=1984 and production_year>=1980);
create or replace view aggView2428696394450596447 as select v38, v39 from aggJoin6884401939713761385 group by v38,v39;
create or replace view aggJoin1500732289978031853 as (
with aggView4941779584990358603 as (select v24 from aggJoin5586246501003136340 group by v24)
select v24, v25, v28, v29 from aggJoin457934428799072477 join aggView4941779584990358603 using(v24));
create or replace view aggView2018826462974217688 as select v25, v24 from aggJoin1500732289978031853 group by v25,v24;
create or replace view aggJoin1689967686771674677 as (
with aggView9022006338526917376 as (select v38, MIN(v39) as v51 from aggView2428696394450596447 group by v38)
select person_id as v24, v51 from cast_info as ci, aggView9022006338526917376 where ci.movie_id=aggView9022006338526917376.v38);
create or replace view aggJoin4805399330941575041 as (
with aggView1336254444895118292 as (select v24, MIN(v51) as v51 from aggJoin1689967686771674677 group by v24,v51)
select v25, v51 from aggView2018826462974217688 join aggView1336254444895118292 using(v24));
select MIN(v25) as v50,MIN(v51) as v51 from aggJoin4805399330941575041;
