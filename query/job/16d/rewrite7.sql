create or replace view aggJoin8182385017891393575 as (
with aggView4550088099983016338 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView4550088099983016338 where mc.company_id=aggView4550088099983016338.v28);
create or replace view aggJoin5514316495341718066 as (
with aggView105537351064838496 as (select v11 from aggJoin8182385017891393575 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView105537351064838496 where t.id=aggView105537351064838496.v11 and episode_nr>=5 and episode_nr<100);
create or replace view aggJoin7061681956859553643 as (
with aggView2550925527278950389 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView2550925527278950389 where mk.keyword_id=aggView2550925527278950389.v33);
create or replace view aggJoin4095423752288470093 as (
with aggView1583499836505041342 as (select v11 from aggJoin7061681956859553643 group by v11)
select v11, v44, v52 from aggJoin5514316495341718066 join aggView1583499836505041342 using(v11));
create or replace view aggJoin308287576309813174 as (
with aggView6510632101602599490 as (select v11, MIN(v44) as v56 from aggJoin4095423752288470093 group by v11)
select person_id as v2, v56 from cast_info as ci, aggView6510632101602599490 where ci.movie_id=aggView6510632101602599490.v11);
create or replace view aggJoin7824410824912879367 as (
with aggView4372234030393990430 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView4372234030393990430 where an.person_id=aggView4372234030393990430.v2);
create or replace view aggJoin1388049364194809287 as (
with aggView1070469745523089614 as (select v2, MIN(v3) as v55 from aggJoin7824410824912879367 group by v2)
select v56 as v56, v55 from aggJoin308287576309813174 join aggView1070469745523089614 using(v2));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin1388049364194809287;
