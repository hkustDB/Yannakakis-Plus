create or replace view aggJoin4802455241673978985 as (
with aggView7014605817248993573 as (select id as v38, title as v51 from title as t where production_year<=1984 and production_year>=1980)
select linked_movie_id as v38, link_type_id as v18, v51 from movie_link as ml, aggView7014605817248993573 where ml.linked_movie_id=aggView7014605817248993573.v38);
create or replace view aggJoin803595121866115568 as (
with aggView8367231036246757623 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select id as v24, name as v25, gender as v28, name_pcode_cf as v29 from name as n, aggView8367231036246757623 where n.id=aggView8367231036246757623.v24 and gender= 'm' and name_pcode_cf LIKE 'D%');
create or replace view aggJoin7178354340571641825 as (
with aggView6348427474391476000 as (select v24, MIN(v25) as v50 from aggJoin803595121866115568 group by v24)
select person_id as v24, info_type_id as v16, note as v37, v50 from person_info as pi, aggView6348427474391476000 where pi.person_id=aggView6348427474391476000.v24 and note= 'Volker Boehm');
create or replace view aggJoin9138295142747590054 as (
with aggView3016911486918032202 as (select id as v16 from info_type as it where info= 'mini biography')
select v24, v37, v50 from aggJoin7178354340571641825 join aggView3016911486918032202 using(v16));
create or replace view aggJoin4184199019158591821 as (
with aggView5983624460663850626 as (select v24, MIN(v50) as v50 from aggJoin9138295142747590054 group by v24,v50)
select movie_id as v38, v50 from cast_info as ci, aggView5983624460663850626 where ci.person_id=aggView5983624460663850626.v24);
create or replace view aggJoin2362017222289752859 as (
with aggView6068442575364722510 as (select id as v18 from link_type as lt where link= 'features')
select v38, v51 from aggJoin4802455241673978985 join aggView6068442575364722510 using(v18));
create or replace view aggJoin2881526075723440195 as (
with aggView979339663597210019 as (select v38, MIN(v51) as v51 from aggJoin2362017222289752859 group by v38,v51)
select v50 as v50, v51 from aggJoin4184199019158591821 join aggView979339663597210019 using(v38));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin2881526075723440195;
