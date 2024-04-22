create or replace view aggJoin1017187839136208771 as (
with aggView8002857918447264091 as (select id as v24, name as v50 from name as n where name LIKE 'A%' and name_pcode_cf>='A' and name_pcode_cf<='F')
select person_id as v24, name as v3, v50 from aka_name as an, aggView8002857918447264091 where an.person_id=aggView8002857918447264091.v24 and ((name LIKE '%a%') OR (name LIKE 'A%')));
create or replace view aggJoin1173348814616420522 as (
with aggView473639236790444704 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, info as v36 from person_info as pi, aggView473639236790444704 where pi.info_type_id=aggView473639236790444704.v16);
create or replace view aggJoin8997087553233346425 as (
with aggView8451117415011893373 as (select id as v18 from link_type as lt where link IN ('references','referenced in','features','featured in'))
select linked_movie_id as v38 from movie_link as ml, aggView8451117415011893373 where ml.link_type_id=aggView8451117415011893373.v18);
create or replace view aggJoin8592882117240499520 as (
with aggView5297020795961792169 as (select v38 from aggJoin8997087553233346425 group by v38)
select id as v38, production_year as v42 from title as t, aggView5297020795961792169 where t.id=aggView5297020795961792169.v38 and production_year<=2010 and production_year>=1980);
create or replace view aggJoin6944519315506917832 as (
with aggView8222733539572175286 as (select v24, MIN(v50) as v50 from aggJoin1017187839136208771 group by v24,v50)
select v24, v36, v50 from aggJoin1173348814616420522 join aggView8222733539572175286 using(v24));
create or replace view aggJoin269258331279445665 as (
with aggView6229344711909204386 as (select v24, MIN(v50) as v50, MIN(v36) as v51 from aggJoin6944519315506917832 group by v24,v50)
select movie_id as v38, v50, v51 from cast_info as ci, aggView6229344711909204386 where ci.person_id=aggView6229344711909204386.v24);
create or replace view aggJoin3186008831016700545 as (
with aggView3690514208892452664 as (select v38 from aggJoin8592882117240499520 group by v38)
select v50 as v50, v51 as v51 from aggJoin269258331279445665 join aggView3690514208892452664 using(v38));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin3186008831016700545;
