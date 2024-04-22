create or replace view aggJoin3773684903447125199 as (
with aggView4443611175496877434 as (select id as v1, name as v41 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView4443611175496877434 where mc.company_id=aggView4443611175496877434.v1);
create or replace view aggJoin271997173633085628 as (
with aggView5147143833947951057 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView5147143833947951057 where mi.info_type_id=aggView5147143833947951057.v21 and info IN ('Drama','Horror'));
create or replace view aggJoin3517788901394894277 as (
with aggView4679529669333105447 as (select v29 from aggJoin271997173633085628 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView4679529669333105447 where t.id=aggView4679529669333105447.v29 and production_year<=2008 and production_year>=2005);
create or replace view aggJoin6801762894777569880 as (
with aggView8355700833192683756 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin3773684903447125199 join aggView8355700833192683756 using(v8));
create or replace view aggJoin1804802130157644140 as (
with aggView7247818611692708178 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView7247818611692708178 where mi_idx.info_type_id=aggView7247818611692708178.v26 and info>'8.0');
create or replace view aggJoin2740625626505702441 as (
with aggView4832821778577033970 as (select v29, MIN(v27) as v42 from aggJoin1804802130157644140 group by v29)
select v29, v30, v33, v42 from aggJoin3517788901394894277 join aggView4832821778577033970 using(v29));
create or replace view aggJoin2016862074204528180 as (
with aggView6329165018362132548 as (select v29, MIN(v42) as v42, MIN(v30) as v43 from aggJoin2740625626505702441 group by v29,v42)
select v41 as v41, v42, v43 from aggJoin6801762894777569880 join aggView6329165018362132548 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin2016862074204528180;
