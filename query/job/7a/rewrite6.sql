create or replace view aggJoin7677289733162582365 as (
with aggView6280543693068948476 as (select id as v24, name as v50 from name as n where name_pcode_cf>='A' and name LIKE 'B%' and name_pcode_cf<='F')
select person_id as v24, info_type_id as v16, note as v37, v50 from person_info as pi, aggView6280543693068948476 where pi.person_id=aggView6280543693068948476.v24 and note= 'Volker Boehm');
create or replace view aggJoin3920878492910676963 as (
with aggView2393714980900322237 as (select id as v16 from info_type as it where info= 'mini biography')
select v24, v37, v50 from aggJoin7677289733162582365 join aggView2393714980900322237 using(v16));
create or replace view aggJoin7156983728975234042 as (
with aggView608986202517107171 as (select v24, MIN(v50) as v50 from aggJoin3920878492910676963 group by v24,v50)
select person_id as v24, name as v3, v50 from aka_name as an, aggView608986202517107171 where an.person_id=aggView608986202517107171.v24 and name LIKE '%a%');
create or replace view aggJoin9050644326955382591 as (
with aggView8576079540711286241 as (select v24, MIN(v50) as v50 from aggJoin7156983728975234042 group by v24,v50)
select movie_id as v38, v50 from cast_info as ci, aggView8576079540711286241 where ci.person_id=aggView8576079540711286241.v24);
create or replace view aggJoin2281685686637968709 as (
with aggView7248967979563304375 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView7248967979563304375 where ml.link_type_id=aggView7248967979563304375.v18);
create or replace view aggJoin5224852843916984006 as (
with aggView2644305595241649844 as (select v38 from aggJoin2281685686637968709 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView2644305595241649844 where t.id=aggView2644305595241649844.v38 and production_year>=1980 and production_year<=1995);
create or replace view aggJoin2011475724722654827 as (
with aggView5897625301216408088 as (select v38, MIN(v39) as v51 from aggJoin5224852843916984006 group by v38)
select v50 as v50, v51 from aggJoin9050644326955382591 join aggView5897625301216408088 using(v38));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin2011475724722654827;
