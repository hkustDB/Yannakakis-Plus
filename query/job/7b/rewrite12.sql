create or replace view aggView9016666570306900180 as select name as v25, id as v24 from name as n where gender= 'm' and name_pcode_cf LIKE 'D%';
create or replace view aggJoin5256437206236535174 as (
with aggView1010165358377898623 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView1010165358377898623 where ml.link_type_id=aggView1010165358377898623.v18);
create or replace view aggJoin1096575805666624711 as (
with aggView6653643026820619670 as (select v38 from aggJoin5256437206236535174 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView6653643026820619670 where t.id=aggView6653643026820619670.v38 and production_year<=1984 and production_year>=1980);
create or replace view aggView5753864535197613176 as select v38, v39 from aggJoin1096575805666624711 group by v38,v39;
create or replace view aggJoin7795107016529779546 as (
with aggView751410790793285587 as (select v38, MIN(v39) as v51 from aggView5753864535197613176 group by v38)
select person_id as v24, v51 from cast_info as ci, aggView751410790793285587 where ci.movie_id=aggView751410790793285587.v38);
create or replace view aggJoin5265147365291174442 as (
with aggView2341263364886648056 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select v24, v51 as v51 from aggJoin7795107016529779546 join aggView2341263364886648056 using(v24));
create or replace view aggJoin2340155199461068686 as (
with aggView7365725440098368471 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView7365725440098368471 where pi.info_type_id=aggView7365725440098368471.v16 and note= 'Volker Boehm');
create or replace view aggJoin192268862601013830 as (
with aggView4351874279824363277 as (select v24 from aggJoin2340155199461068686 group by v24)
select v24, v51 as v51 from aggJoin5265147365291174442 join aggView4351874279824363277 using(v24));
create or replace view aggJoin5570031853337605671 as (
with aggView5236612165579948035 as (select v24, MIN(v51) as v51 from aggJoin192268862601013830 group by v24,v51)
select v25, v51 from aggView9016666570306900180 join aggView5236612165579948035 using(v24));
select MIN(v25) as v50,MIN(v51) as v51 from aggJoin5570031853337605671;
