create or replace view aggJoin9109800412892695040 as (
with aggView5969925003530534793 as (select id as v1, name as v41 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView5969925003530534793 where mc.company_id=aggView5969925003530534793.v1);
create or replace view aggJoin4735445275684614611 as (
with aggView6727697941844874936 as (select id as v29, title as v43 from title as t where production_year<=2008 and production_year>=2005)
select movie_id as v29, info_type_id as v26, info as v27, v43 from movie_info_idx as mi_idx, aggView6727697941844874936 where mi_idx.movie_id=aggView6727697941844874936.v29 and info>'8.0');
create or replace view aggJoin3315263643660511436 as (
with aggView3402357722418192948 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView3402357722418192948 where mi.info_type_id=aggView3402357722418192948.v21 and info IN ('Drama','Horror'));
create or replace view aggJoin5474564210758628796 as (
with aggView7909907267393098076 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin9109800412892695040 join aggView7909907267393098076 using(v8));
create or replace view aggJoin3511348964984703653 as (
with aggView6286130795840593743 as (select id as v26 from info_type as it2 where info= 'rating')
select v29, v27, v43 from aggJoin4735445275684614611 join aggView6286130795840593743 using(v26));
create or replace view aggJoin3587630423528653366 as (
with aggView703525528084453523 as (select v29, MIN(v43) as v43, MIN(v27) as v42 from aggJoin3511348964984703653 group by v29,v43)
select v29, v22, v43, v42 from aggJoin3315263643660511436 join aggView703525528084453523 using(v29));
create or replace view aggJoin60318153696059473 as (
with aggView4648116765688166126 as (select v29, MIN(v43) as v43, MIN(v42) as v42 from aggJoin3587630423528653366 group by v29,v43,v42)
select v41 as v41, v43, v42 from aggJoin5474564210758628796 join aggView4648116765688166126 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin60318153696059473;
