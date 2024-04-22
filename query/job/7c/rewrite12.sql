create or replace view aggJoin5974499020374464362 as (
with aggView7820687397126897261 as (select id as v24, name as v50 from name as n where name LIKE 'A%' and name_pcode_cf>='A' and name_pcode_cf<='F')
select person_id as v24, info_type_id as v16, info as v36, v50 from person_info as pi, aggView7820687397126897261 where pi.person_id=aggView7820687397126897261.v24);
create or replace view aggJoin40061955628322516 as (
with aggView5201025919677794517 as (select id as v16 from info_type as it where info= 'mini biography')
select v24, v36, v50 from aggJoin5974499020374464362 join aggView5201025919677794517 using(v16));
create or replace view aggJoin4609271937873228051 as (
with aggView4891376108591200117 as (select v24, MIN(v50) as v50, MIN(v36) as v51 from aggJoin40061955628322516 group by v24,v50)
select person_id as v24, name as v3, v50, v51 from aka_name as an, aggView4891376108591200117 where an.person_id=aggView4891376108591200117.v24 and ((name LIKE '%a%') OR (name LIKE 'A%')));
create or replace view aggJoin6599050221498877204 as (
with aggView8272340284853252576 as (select id as v38 from title as t where production_year<=2010 and production_year>=1980)
select linked_movie_id as v38, link_type_id as v18 from movie_link as ml, aggView8272340284853252576 where ml.linked_movie_id=aggView8272340284853252576.v38);
create or replace view aggJoin5451736951523856937 as (
with aggView6358067424305194313 as (select id as v18 from link_type as lt where link IN ('references','referenced in','features','featured in'))
select v38 from aggJoin6599050221498877204 join aggView6358067424305194313 using(v18));
create or replace view aggJoin7111846018384922274 as (
with aggView3333357816896679667 as (select v24, MIN(v50) as v50, MIN(v51) as v51 from aggJoin4609271937873228051 group by v24,v51,v50)
select movie_id as v38, v50, v51 from cast_info as ci, aggView3333357816896679667 where ci.person_id=aggView3333357816896679667.v24);
create or replace view aggJoin7024863596964715811 as (
with aggView5380435424675703059 as (select v38 from aggJoin5451736951523856937 group by v38)
select v50 as v50, v51 as v51 from aggJoin7111846018384922274 join aggView5380435424675703059 using(v38));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin7024863596964715811;
