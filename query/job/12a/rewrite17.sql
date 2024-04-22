create or replace view aggJoin1058515236544358508 as (
with aggView7044794425215950278 as (select id as v1, name as v41 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView7044794425215950278 where mc.company_id=aggView7044794425215950278.v1);
create or replace view aggJoin5805564072189466014 as (
with aggView478095707642038471 as (select id as v29, title as v43 from title as t where production_year<=2008 and production_year>=2005)
select movie_id as v29, info_type_id as v26, info as v27, v43 from movie_info_idx as mi_idx, aggView478095707642038471 where mi_idx.movie_id=aggView478095707642038471.v29 and info>'8.0');
create or replace view aggJoin3874166345233288463 as (
with aggView7382994517330702522 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView7382994517330702522 where mi.info_type_id=aggView7382994517330702522.v21 and info IN ('Drama','Horror'));
create or replace view aggJoin5907613087531490432 as (
with aggView2079236495114159752 as (select v29 from aggJoin3874166345233288463 group by v29)
select v29, v26, v27, v43 as v43 from aggJoin5805564072189466014 join aggView2079236495114159752 using(v29));
create or replace view aggJoin7622730701152843356 as (
with aggView6961182532500778560 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin1058515236544358508 join aggView6961182532500778560 using(v8));
create or replace view aggJoin7448254090621521777 as (
with aggView9137341035504988053 as (select id as v26 from info_type as it2 where info= 'rating')
select v29, v27, v43 from aggJoin5907613087531490432 join aggView9137341035504988053 using(v26));
create or replace view aggJoin8152871585639654857 as (
with aggView3628912199596064736 as (select v29, MIN(v43) as v43, MIN(v27) as v42 from aggJoin7448254090621521777 group by v29,v43)
select v41 as v41, v43, v42 from aggJoin7622730701152843356 join aggView3628912199596064736 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin8152871585639654857;
