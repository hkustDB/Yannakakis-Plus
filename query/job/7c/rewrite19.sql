create or replace view aggJoin6349198480683301315 as (
with aggView5291085904029387456 as (select id as v24, name as v50 from name as n where name LIKE 'A%' and name_pcode_cf>='A' and name_pcode_cf<='F')
select person_id as v24, movie_id as v38, v50 from cast_info as ci, aggView5291085904029387456 where ci.person_id=aggView5291085904029387456.v24);
create or replace view aggJoin8494033296431678023 as (
with aggView3476807162483503086 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, info as v36 from person_info as pi, aggView3476807162483503086 where pi.info_type_id=aggView3476807162483503086.v16);
create or replace view aggJoin7516406173021268140 as (
with aggView2118587647047865313 as (select v24, MIN(v36) as v51 from aggJoin8494033296431678023 group by v24)
select person_id as v24, name as v3, v51 from aka_name as an, aggView2118587647047865313 where an.person_id=aggView2118587647047865313.v24 and ((name LIKE '%a%') OR (name LIKE 'A%')));
create or replace view aggJoin6141327146793576714 as (
with aggView4161367107986902319 as (select id as v18 from link_type as lt where link IN ('references','referenced in','features','featured in'))
select linked_movie_id as v38 from movie_link as ml, aggView4161367107986902319 where ml.link_type_id=aggView4161367107986902319.v18);
create or replace view aggJoin2595696064633689759 as (
with aggView1610378894265158039 as (select id as v38 from title as t where production_year<=2010 and production_year>=1980)
select v24, v38, v50 from aggJoin6349198480683301315 join aggView1610378894265158039 using(v38));
create or replace view aggJoin1855579737796836144 as (
with aggView1133165951186525374 as (select v24, MIN(v51) as v51 from aggJoin7516406173021268140 group by v24,v51)
select v38, v50 as v50, v51 from aggJoin2595696064633689759 join aggView1133165951186525374 using(v24));
create or replace view aggJoin514447676723095977 as (
with aggView3499584231900080822 as (select v38 from aggJoin6141327146793576714 group by v38)
select v50 as v50, v51 as v51 from aggJoin1855579737796836144 join aggView3499584231900080822 using(v38));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin514447676723095977;
