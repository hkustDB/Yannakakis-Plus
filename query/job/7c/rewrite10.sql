create or replace view aggJoin8980457294475068015 as (
with aggView8049751742643783404 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, info as v36 from person_info as pi, aggView8049751742643783404 where pi.info_type_id=aggView8049751742643783404.v16);
create or replace view aggJoin8334439988047255686 as (
with aggView7549386092756550319 as (select id as v38 from title as t where production_year<=2010 and production_year>=1980)
select linked_movie_id as v38, link_type_id as v18 from movie_link as ml, aggView7549386092756550319 where ml.linked_movie_id=aggView7549386092756550319.v38);
create or replace view aggJoin8772993304532410235 as (
with aggView8440671916367713358 as (select id as v18 from link_type as lt where link IN ('references','referenced in','features','featured in'))
select v38 from aggJoin8334439988047255686 join aggView8440671916367713358 using(v18));
create or replace view aggJoin6593621946982360800 as (
with aggView5629535959900584982 as (select person_id as v24 from aka_name as an where ((name LIKE '%a%') OR (name LIKE 'A%')) group by person_id)
select v24, v36 from aggJoin8980457294475068015 join aggView5629535959900584982 using(v24));
create or replace view aggJoin9153724750851881234 as (
with aggView3070736799211477870 as (select v24, MIN(v36) as v51 from aggJoin6593621946982360800 group by v24)
select id as v24, name as v25, name_pcode_cf as v29, v51 from name as n, aggView3070736799211477870 where n.id=aggView3070736799211477870.v24 and name LIKE 'A%' and name_pcode_cf>='A' and name_pcode_cf<='F');
create or replace view aggJoin2821650076999720499 as (
with aggView1582999482058085879 as (select v24, MIN(v51) as v51, MIN(v25) as v50 from aggJoin9153724750851881234 group by v24,v51)
select movie_id as v38, v51, v50 from cast_info as ci, aggView1582999482058085879 where ci.person_id=aggView1582999482058085879.v24);
create or replace view aggJoin8518446512770291453 as (
with aggView2671932827706914325 as (select v38 from aggJoin8772993304532410235 group by v38)
select v51 as v51, v50 as v50 from aggJoin2821650076999720499 join aggView2671932827706914325 using(v38));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin8518446512770291453;
