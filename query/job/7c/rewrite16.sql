create or replace view aggJoin5326084485418481453 as (
with aggView7008798214210834242 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, info as v36 from person_info as pi, aggView7008798214210834242 where pi.info_type_id=aggView7008798214210834242.v16);
create or replace view aggJoin5864876942941603868 as (
with aggView7602787173192602623 as (select v24, MIN(v36) as v51 from aggJoin5326084485418481453 group by v24)
select id as v24, name as v25, name_pcode_cf as v29, v51 from name as n, aggView7602787173192602623 where n.id=aggView7602787173192602623.v24 and name LIKE 'A%' and name_pcode_cf>='A' and name_pcode_cf<='F');
create or replace view aggJoin1431373150126898986 as (
with aggView8379652972943798650 as (select id as v18 from link_type as lt where link IN ('references','referenced in','features','featured in'))
select linked_movie_id as v38 from movie_link as ml, aggView8379652972943798650 where ml.link_type_id=aggView8379652972943798650.v18);
create or replace view aggJoin5108047788561623888 as (
with aggView7400818431053519392 as (select id as v38 from title as t where production_year<=2010 and production_year>=1980)
select person_id as v24, movie_id as v38 from cast_info as ci, aggView7400818431053519392 where ci.movie_id=aggView7400818431053519392.v38);
create or replace view aggJoin4867433779595792342 as (
with aggView8707073206008452132 as (select person_id as v24 from aka_name as an where ((name LIKE '%a%') OR (name LIKE 'A%')) group by person_id)
select v24, v25, v29, v51 as v51 from aggJoin5864876942941603868 join aggView8707073206008452132 using(v24));
create or replace view aggJoin6374174815720817775 as (
with aggView6885779621731347795 as (select v24, MIN(v51) as v51, MIN(v25) as v50 from aggJoin4867433779595792342 group by v24,v51)
select v38, v51, v50 from aggJoin5108047788561623888 join aggView6885779621731347795 using(v24));
create or replace view aggJoin2633123022225079525 as (
with aggView1881407079576500842 as (select v38 from aggJoin1431373150126898986 group by v38)
select v51 as v51, v50 as v50 from aggJoin6374174815720817775 join aggView1881407079576500842 using(v38));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin2633123022225079525;
