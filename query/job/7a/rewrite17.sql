create or replace view aggJoin1985545131316692173 as (
with aggView4694002754211581550 as (select id as v24, name as v50 from name as n where name_pcode_cf>='A' and name LIKE 'B%' and name_pcode_cf<='F')
select person_id as v24, name as v3, v50 from aka_name as an, aggView4694002754211581550 where an.person_id=aggView4694002754211581550.v24 and name LIKE '%a%');
create or replace view aggJoin6180963082868235616 as (
with aggView3833408142331579109 as (select id as v38, title as v51 from title as t where production_year>=1980 and production_year<=1995)
select linked_movie_id as v38, link_type_id as v18, v51 from movie_link as ml, aggView3833408142331579109 where ml.linked_movie_id=aggView3833408142331579109.v38);
create or replace view aggJoin3990290714088387173 as (
with aggView7819025483629550383 as (select v24, MIN(v50) as v50 from aggJoin1985545131316692173 group by v24,v50)
select person_id as v24, movie_id as v38, v50 from cast_info as ci, aggView7819025483629550383 where ci.person_id=aggView7819025483629550383.v24);
create or replace view aggJoin1333330467969809899 as (
with aggView7231420164686228622 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView7231420164686228622 where pi.info_type_id=aggView7231420164686228622.v16 and note= 'Volker Boehm');
create or replace view aggJoin1675774914258593026 as (
with aggView7658625847839979236 as (select id as v18 from link_type as lt where link= 'features')
select v38, v51 from aggJoin6180963082868235616 join aggView7658625847839979236 using(v18));
create or replace view aggJoin3680040497796151273 as (
with aggView4860609592031151249 as (select v38, MIN(v51) as v51 from aggJoin1675774914258593026 group by v38,v51)
select v24, v50 as v50, v51 from aggJoin3990290714088387173 join aggView4860609592031151249 using(v38));
create or replace view aggJoin2650663964407080912 as (
with aggView7920445725255503520 as (select v24 from aggJoin1333330467969809899 group by v24)
select v50 as v50, v51 as v51 from aggJoin3680040497796151273 join aggView7920445725255503520 using(v24));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin2650663964407080912;
