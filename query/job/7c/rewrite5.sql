create or replace view aggJoin8666584847610636478 as (
with aggView6097315117415572118 as (select name as v25, id as v24 from name as n where name_pcode_cf>='A' and name_pcode_cf<='F')
select v24, v25 from aggView6097315117415572118 where v25 LIKE 'A%');
create or replace view aggJoin5599075312834007901 as (
with aggView4601704778003394122 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, info as v36 from person_info as pi, aggView4601704778003394122 where pi.info_type_id=aggView4601704778003394122.v16);
create or replace view aggJoin386177799184420278 as (
with aggView8971623851024215704 as (select id as v18 from link_type as lt where link IN ('references','referenced in','features','featured in'))
select linked_movie_id as v38 from movie_link as ml, aggView8971623851024215704 where ml.link_type_id=aggView8971623851024215704.v18);
create or replace view aggJoin4094007364948345987 as (
with aggView5563326552091277543 as (select v38 from aggJoin386177799184420278 group by v38)
select id as v38, production_year as v42 from title as t, aggView5563326552091277543 where t.id=aggView5563326552091277543.v38 and production_year<=2010 and production_year>=1980);
create or replace view aggJoin2172399120800785013 as (
with aggView5716578604677067472 as (select v38 from aggJoin4094007364948345987 group by v38)
select person_id as v24 from cast_info as ci, aggView5716578604677067472 where ci.movie_id=aggView5716578604677067472.v38);
create or replace view aggJoin8053517139792489023 as (
with aggView6317514692710170222 as (select v24 from aggJoin2172399120800785013 group by v24)
select person_id as v24, name as v3 from aka_name as an, aggView6317514692710170222 where an.person_id=aggView6317514692710170222.v24 and ((name LIKE '%a%') OR (name LIKE 'A%')));
create or replace view aggJoin3483400382660166931 as (
with aggView6250718026820099741 as (select v24 from aggJoin8053517139792489023 group by v24)
select v24, v36 from aggJoin5599075312834007901 join aggView6250718026820099741 using(v24));
create or replace view aggView1787643808696009415 as select v24, v36 from aggJoin3483400382660166931 group by v24,v36;
create or replace view aggJoin3601762194198866068 as (
with aggView4129624337119120503 as (select v24, MIN(v25) as v50 from aggJoin8666584847610636478 group by v24)
select v36, v50 from aggView1787643808696009415 join aggView4129624337119120503 using(v24));
select MIN(v50) as v50,MIN(v36) as v51 from aggJoin3601762194198866068;
