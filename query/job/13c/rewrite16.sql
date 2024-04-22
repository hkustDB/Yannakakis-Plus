create or replace view aggJoin2875151470043394429 as (
with aggView4324565662304873021 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView4324565662304873021 where mc.company_id=aggView4324565662304873021.v1);
create or replace view aggJoin1534114174552060530 as (
with aggView1257489823622536632 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin2875151470043394429 join aggView1257489823622536632 using(v8));
create or replace view aggJoin6009545271634588587 as (
with aggView3520654392859597606 as (select v22, MIN(v43) as v43 from aggJoin1534114174552060530 group by v22,v43)
select id as v22, title as v32, kind_id as v14, v43 from title as t, aggView3520654392859597606 where t.id=aggView3520654392859597606.v22 and title<> '' and ((title LIKE 'Champion%') OR (title LIKE 'Loser%')));
create or replace view aggJoin3798471215391509624 as (
with aggView6786197709354277759 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView6786197709354277759 where miidx.info_type_id=aggView6786197709354277759.v10);
create or replace view aggJoin5900631394101063412 as (
with aggView2691454408509378267 as (select v22, MIN(v29) as v44 from aggJoin3798471215391509624 group by v22)
select movie_id as v22, info_type_id as v12, v44 from movie_info as mi, aggView2691454408509378267 where mi.movie_id=aggView2691454408509378267.v22);
create or replace view aggJoin3217559018002538279 as (
with aggView7839834483267933374 as (select id as v12 from info_type as it2 where info= 'release dates')
select v22, v44 from aggJoin5900631394101063412 join aggView7839834483267933374 using(v12));
create or replace view aggJoin112504044570190875 as (
with aggView4347339582297272578 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32, v43 from aggJoin6009545271634588587 join aggView4347339582297272578 using(v14));
create or replace view aggJoin8774037980302932885 as (
with aggView6586509216730474036 as (select v22, MIN(v43) as v43, MIN(v32) as v45 from aggJoin112504044570190875 group by v22,v43)
select v44 as v44, v43, v45 from aggJoin3217559018002538279 join aggView6586509216730474036 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin8774037980302932885;
