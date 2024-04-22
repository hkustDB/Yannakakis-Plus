create or replace view aggView5995461430194958904 as select title as v39, id as v38 from title as t where production_year>=1980 and production_year<=1995;
create or replace view aggJoin6644997214118071981 as (
with aggView3100075134665774473 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select id as v24, name as v25, name_pcode_cf as v29 from name as n, aggView3100075134665774473 where n.id=aggView3100075134665774473.v24 and name_pcode_cf>='A' and name LIKE 'B%' and name_pcode_cf<='F');
create or replace view aggView2159609862674192364 as select v25, v24 from aggJoin6644997214118071981 group by v25,v24;
create or replace view aggJoin5023627330328881276 as (
with aggView6858577616528327807 as (select v38, MIN(v39) as v51 from aggView5995461430194958904 group by v38)
select person_id as v24, movie_id as v38, v51 from cast_info as ci, aggView6858577616528327807 where ci.movie_id=aggView6858577616528327807.v38);
create or replace view aggJoin8028287409415553531 as (
with aggView8305237880759663543 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView8305237880759663543 where pi.info_type_id=aggView8305237880759663543.v16 and note= 'Volker Boehm');
create or replace view aggJoin7825037246141078952 as (
with aggView7297423998309784817 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView7297423998309784817 where ml.link_type_id=aggView7297423998309784817.v18);
create or replace view aggJoin7155528860563174337 as (
with aggView6178204618448994937 as (select v38 from aggJoin7825037246141078952 group by v38)
select v24, v51 as v51 from aggJoin5023627330328881276 join aggView6178204618448994937 using(v38));
create or replace view aggJoin8920513435790287809 as (
with aggView4449741979784800659 as (select v24 from aggJoin8028287409415553531 group by v24)
select v24, v51 as v51 from aggJoin7155528860563174337 join aggView4449741979784800659 using(v24));
create or replace view aggJoin4883830439893586123 as (
with aggView8201774315736112235 as (select v24, MIN(v51) as v51 from aggJoin8920513435790287809 group by v24,v51)
select v25, v51 from aggView2159609862674192364 join aggView8201774315736112235 using(v24));
select MIN(v25) as v50,MIN(v51) as v51 from aggJoin4883830439893586123;
