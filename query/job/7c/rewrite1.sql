create or replace view aggView7583080004395952819 as select name as v25, id as v24 from name as n where name LIKE 'A%' and name_pcode_cf>='A' and name_pcode_cf<='F';
create or replace view aggJoin7566778116346430405 as (
with aggView3152033546116030706 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, info as v36 from person_info as pi, aggView3152033546116030706 where pi.info_type_id=aggView3152033546116030706.v16);
create or replace view aggJoin1544336651278185796 as (
with aggView8328378917813225074 as (select id as v18 from link_type as lt where link IN ('references','referenced in','features','featured in'))
select linked_movie_id as v38 from movie_link as ml, aggView8328378917813225074 where ml.link_type_id=aggView8328378917813225074.v18);
create or replace view aggJoin8579016924036067153 as (
with aggView3002393696589955193 as (select v38 from aggJoin1544336651278185796 group by v38)
select id as v38, production_year as v42 from title as t, aggView3002393696589955193 where t.id=aggView3002393696589955193.v38 and production_year<=2010 and production_year>=1980);
create or replace view aggJoin7746344921499160757 as (
with aggView7750560567052437560 as (select v38 from aggJoin8579016924036067153 group by v38)
select person_id as v24 from cast_info as ci, aggView7750560567052437560 where ci.movie_id=aggView7750560567052437560.v38);
create or replace view aggJoin6673232736515278307 as (
with aggView7147717385178273955 as (select person_id as v24 from aka_name as an where ((name LIKE '%a%') OR (name LIKE 'A%')) group by person_id)
select v24 from aggJoin7746344921499160757 join aggView7147717385178273955 using(v24));
create or replace view aggJoin557957800413401045 as (
with aggView6112874402137239870 as (select v24 from aggJoin6673232736515278307 group by v24)
select v24, v36 from aggJoin7566778116346430405 join aggView6112874402137239870 using(v24));
create or replace view aggView7524732888799121960 as select v24, v36 from aggJoin557957800413401045 group by v24,v36;
create or replace view aggJoin2082509458651956424 as (
with aggView4125856902235454122 as (select v24, MIN(v25) as v50 from aggView7583080004395952819 group by v24)
select v36, v50 from aggView7524732888799121960 join aggView4125856902235454122 using(v24));
select MIN(v50) as v50,MIN(v36) as v51 from aggJoin2082509458651956424;
