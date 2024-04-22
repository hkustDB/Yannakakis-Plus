create or replace view aggView4905283678630261976 as select name as v3, person_id as v35 from aka_name as an group by name,person_id;
create or replace view aggJoin1752171103889401428 as (
with aggView5698414961185428266 as (select name as v36, id as v35 from name as n where gender= 'f')
select v35, v36 from aggView5698414961185428266 where v36 LIKE '%Angel%');
create or replace view aggView5332335920304993908 as select id as v9, name as v10 from char_name as chn;
create or replace view aggJoin4921581225732239528 as (
with aggView2116689355826296150 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18, note as v34 from movie_companies as mc, aggView2116689355826296150 where mc.company_id=aggView2116689355826296150.v32 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin3971003671681316917 as (
with aggView6895947099547636598 as (select v18 from aggJoin4921581225732239528 group by v18)
select id as v18, title as v47, production_year as v50 from title as t, aggView6895947099547636598 where t.id=aggView6895947099547636598.v18 and production_year>=2007 and production_year<=2010);
create or replace view aggView4091098999314691793 as select v47, v18 from aggJoin3971003671681316917 group by v47,v18;
create or replace view aggJoin6330852551076998647 as (
with aggView8841997744001592311 as (select v35, MIN(v36) as v60 from aggJoin1752171103889401428 group by v35)
select person_id as v35, movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v60 from cast_info as ci, aggView8841997744001592311 where ci.person_id=aggView8841997744001592311.v35 and note= '(voice)');
create or replace view aggJoin8265483420421198693 as (
with aggView2023840347711495901 as (select v35, MIN(v3) as v58 from aggView4905283678630261976 group by v35)
select v18, v9, v20, v22, v60 as v60, v58 from aggJoin6330852551076998647 join aggView2023840347711495901 using(v35));
create or replace view aggJoin8730114186787794236 as (
with aggView4531654760913256555 as (select v9, MIN(v10) as v59 from aggView5332335920304993908 group by v9)
select v18, v20, v22, v60 as v60, v58 as v58, v59 from aggJoin8265483420421198693 join aggView4531654760913256555 using(v9));
create or replace view aggJoin8301410371485708577 as (
with aggView7845120561821367346 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v60, v58, v59 from aggJoin8730114186787794236 join aggView7845120561821367346 using(v22));
create or replace view aggJoin5951161255021200606 as (
with aggView7546169588589791119 as (select v18, MIN(v60) as v60, MIN(v58) as v58, MIN(v59) as v59 from aggJoin8301410371485708577 group by v18,v59,v58,v60)
select v47, v60, v58, v59 from aggView4091098999314691793 join aggView7546169588589791119 using(v18));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v47) as v61 from aggJoin5951161255021200606;
