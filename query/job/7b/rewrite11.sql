create or replace view aggView4264353143144371359 as select id as v38, title as v39 from title as t where production_year<=1984 and production_year>=1980;
create or replace view aggJoin8982988026315475804 as (
with aggView8769465913847851043 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView8769465913847851043 where pi.info_type_id=aggView8769465913847851043.v16 and note= 'Volker Boehm');
create or replace view aggJoin8625368251946590242 as (
with aggView3730018226753470317 as (select v24 from aggJoin8982988026315475804 group by v24)
select id as v24, name as v25, gender as v28, name_pcode_cf as v29 from name as n, aggView3730018226753470317 where n.id=aggView3730018226753470317.v24 and gender= 'm' and name_pcode_cf LIKE 'D%');
create or replace view aggView4416511037912115127 as select v25, v24 from aggJoin8625368251946590242 group by v25,v24;
create or replace view aggJoin3358739443093574269 as (
with aggView4057750676751440409 as (select v38, MIN(v39) as v51 from aggView4264353143144371359 group by v38)
select person_id as v24, movie_id as v38, v51 from cast_info as ci, aggView4057750676751440409 where ci.movie_id=aggView4057750676751440409.v38);
create or replace view aggJoin791246224615614399 as (
with aggView6673798606115131130 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select v24, v38, v51 as v51 from aggJoin3358739443093574269 join aggView6673798606115131130 using(v24));
create or replace view aggJoin2863606554175983145 as (
with aggView8294711311047851397 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView8294711311047851397 where ml.link_type_id=aggView8294711311047851397.v18);
create or replace view aggJoin6795574101587621975 as (
with aggView3654987656973175045 as (select v38 from aggJoin2863606554175983145 group by v38)
select v24, v51 as v51 from aggJoin791246224615614399 join aggView3654987656973175045 using(v38));
create or replace view aggJoin9010484121230242289 as (
with aggView7130222954684526680 as (select v24, MIN(v51) as v51 from aggJoin6795574101587621975 group by v24,v51)
select v25, v51 from aggView4416511037912115127 join aggView7130222954684526680 using(v24));
select MIN(v25) as v50,MIN(v51) as v51 from aggJoin9010484121230242289;
