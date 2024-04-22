create or replace view aggJoin4916564083640192352 as (
with aggView235206766490719070 as (select id as v24, name as v50 from name as n where name LIKE 'A%' and name_pcode_cf>='A' and name_pcode_cf<='F')
select person_id as v24, info_type_id as v16, info as v36, v50 from person_info as pi, aggView235206766490719070 where pi.person_id=aggView235206766490719070.v24);
create or replace view aggJoin5036217598712898558 as (
with aggView7571875533783835784 as (select id as v16 from info_type as it where info= 'mini biography')
select v24, v36, v50 from aggJoin4916564083640192352 join aggView7571875533783835784 using(v16));
create or replace view aggJoin2291278599181566337 as (
with aggView3925683766303460139 as (select v24, MIN(v50) as v50, MIN(v36) as v51 from aggJoin5036217598712898558 group by v24,v50)
select person_id as v24, name as v3, v50, v51 from aka_name as an, aggView3925683766303460139 where an.person_id=aggView3925683766303460139.v24 and ((name LIKE '%a%') OR (name LIKE 'A%')));
create or replace view aggJoin3268108056115795785 as (
with aggView7535410920724660551 as (select id as v18 from link_type as lt where link IN ('references','referenced in','features','featured in'))
select linked_movie_id as v38 from movie_link as ml, aggView7535410920724660551 where ml.link_type_id=aggView7535410920724660551.v18);
create or replace view aggJoin587011161821481386 as (
with aggView2994870980997406121 as (select v38 from aggJoin3268108056115795785 group by v38)
select id as v38, production_year as v42 from title as t, aggView2994870980997406121 where t.id=aggView2994870980997406121.v38 and production_year<=2010 and production_year>=1980);
create or replace view aggJoin7264499647466267745 as (
with aggView7507630163519784568 as (select v38 from aggJoin587011161821481386 group by v38)
select person_id as v24 from cast_info as ci, aggView7507630163519784568 where ci.movie_id=aggView7507630163519784568.v38);
create or replace view aggJoin5303181123647835295 as (
with aggView8936282898812831267 as (select v24, MIN(v50) as v50, MIN(v51) as v51 from aggJoin2291278599181566337 group by v24,v51,v50)
select v50, v51 from aggJoin7264499647466267745 join aggView8936282898812831267 using(v24));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin5303181123647835295;
