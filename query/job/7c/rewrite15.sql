create or replace view aggJoin2673020207624109078 as (
with aggView5756586008618798713 as (select id as v24, name as v50 from name as n where name LIKE 'A%' and name_pcode_cf>='A' and name_pcode_cf<='F')
select person_id as v24, info_type_id as v16, info as v36, v50 from person_info as pi, aggView5756586008618798713 where pi.person_id=aggView5756586008618798713.v24);
create or replace view aggJoin249799836056981922 as (
with aggView7427917092002442079 as (select id as v16 from info_type as it where info= 'mini biography')
select v24, v36, v50 from aggJoin2673020207624109078 join aggView7427917092002442079 using(v16));
create or replace view aggJoin7083328425223641995 as (
with aggView6298799128878127242 as (select id as v38 from title as t where production_year<=2010 and production_year>=1980)
select linked_movie_id as v38, link_type_id as v18 from movie_link as ml, aggView6298799128878127242 where ml.linked_movie_id=aggView6298799128878127242.v38);
create or replace view aggJoin4752241861536181641 as (
with aggView481426885668367472 as (select id as v18 from link_type as lt where link IN ('references','referenced in','features','featured in'))
select v38 from aggJoin7083328425223641995 join aggView481426885668367472 using(v18));
create or replace view aggJoin5888507862792527431 as (
with aggView4964433103720689445 as (select person_id as v24 from aka_name as an where ((name LIKE '%a%') OR (name LIKE 'A%')) group by person_id)
select v24, v36, v50 as v50 from aggJoin249799836056981922 join aggView4964433103720689445 using(v24));
create or replace view aggJoin2568897576164125730 as (
with aggView2435289668556803019 as (select v24, MIN(v50) as v50, MIN(v36) as v51 from aggJoin5888507862792527431 group by v24,v50)
select movie_id as v38, v50, v51 from cast_info as ci, aggView2435289668556803019 where ci.person_id=aggView2435289668556803019.v24);
create or replace view aggJoin4474739642751622618 as (
with aggView6700600657394910220 as (select v38 from aggJoin4752241861536181641 group by v38)
select v50 as v50, v51 as v51 from aggJoin2568897576164125730 join aggView6700600657394910220 using(v38));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin4474739642751622618;
