create or replace view aggJoin7599325689374560125 as (
with aggView3192562180008225266 as (select id as v24, name as v50 from name as n where name LIKE 'A%' and name_pcode_cf>='A' and name_pcode_cf<='F')
select person_id as v24, name as v3, v50 from aka_name as an, aggView3192562180008225266 where an.person_id=aggView3192562180008225266.v24 and ((name LIKE '%a%') OR (name LIKE 'A%')));
create or replace view aggJoin4635325755700142901 as (
with aggView6786977111318840253 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, info as v36 from person_info as pi, aggView6786977111318840253 where pi.info_type_id=aggView6786977111318840253.v16);
create or replace view aggJoin4786183810960438525 as (
with aggView967693970385104261 as (select id as v18 from link_type as lt where link IN ('references','referenced in','features','featured in'))
select linked_movie_id as v38 from movie_link as ml, aggView967693970385104261 where ml.link_type_id=aggView967693970385104261.v18);
create or replace view aggJoin8889052074064392662 as (
with aggView2083193825650257360 as (select v24, MIN(v50) as v50 from aggJoin7599325689374560125 group by v24,v50)
select v24, v36, v50 from aggJoin4635325755700142901 join aggView2083193825650257360 using(v24));
create or replace view aggJoin2638902505955824009 as (
with aggView8179499612397955627 as (select v24, MIN(v50) as v50, MIN(v36) as v51 from aggJoin8889052074064392662 group by v24,v50)
select movie_id as v38, v50, v51 from cast_info as ci, aggView8179499612397955627 where ci.person_id=aggView8179499612397955627.v24);
create or replace view aggJoin7402743907811668019 as (
with aggView8451324559415337280 as (select id as v38 from title as t where production_year<=2010 and production_year>=1980)
select v38, v50, v51 from aggJoin2638902505955824009 join aggView8451324559415337280 using(v38));
create or replace view aggJoin4960425209151255031 as (
with aggView2422040769558250929 as (select v38 from aggJoin4786183810960438525 group by v38)
select v50 as v50, v51 as v51 from aggJoin7402743907811668019 join aggView2422040769558250929 using(v38));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin4960425209151255031;
