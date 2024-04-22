create or replace view aggView5691312153137122648 as select name as v25, id as v24 from name as n where name_pcode_cf>='A' and name LIKE 'B%' and name_pcode_cf<='F';
create or replace view aggJoin6032845018306284197 as (
with aggView6363665810041275563 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView6363665810041275563 where ml.link_type_id=aggView6363665810041275563.v18);
create or replace view aggJoin4716509826577338001 as (
with aggView1512806492222599596 as (select v38 from aggJoin6032845018306284197 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView1512806492222599596 where t.id=aggView1512806492222599596.v38 and production_year>=1980 and production_year<=1995);
create or replace view aggView3242535060904692752 as select v39, v38 from aggJoin4716509826577338001 group by v39,v38;
create or replace view aggJoin8375665376386218338 as (
with aggView5630842354906789527 as (select v38, MIN(v39) as v51 from aggView3242535060904692752 group by v38)
select person_id as v24, v51 from cast_info as ci, aggView5630842354906789527 where ci.movie_id=aggView5630842354906789527.v38);
create or replace view aggJoin5082108533265184610 as (
with aggView1515871802361543297 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select v24, v51 as v51 from aggJoin8375665376386218338 join aggView1515871802361543297 using(v24));
create or replace view aggJoin1966924949459249552 as (
with aggView6912840788044053829 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView6912840788044053829 where pi.info_type_id=aggView6912840788044053829.v16 and note= 'Volker Boehm');
create or replace view aggJoin7921781619002230450 as (
with aggView7393243302048356553 as (select v24 from aggJoin1966924949459249552 group by v24)
select v24, v51 as v51 from aggJoin5082108533265184610 join aggView7393243302048356553 using(v24));
create or replace view aggJoin4201862496555328424 as (
with aggView3974546037863653515 as (select v24, MIN(v51) as v51 from aggJoin7921781619002230450 group by v24,v51)
select v25, v51 from aggView5691312153137122648 join aggView3974546037863653515 using(v24));
select MIN(v25) as v50,MIN(v51) as v51 from aggJoin4201862496555328424;
