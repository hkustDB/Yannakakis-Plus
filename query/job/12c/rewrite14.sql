create or replace view aggJoin5283922551452581788 as (
with aggView2262656439330288007 as (select id as v1, name as v41 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView2262656439330288007 where mc.company_id=aggView2262656439330288007.v1);
create or replace view aggJoin8463533126893592696 as (
with aggView5520549120193239847 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin5283922551452581788 join aggView5520549120193239847 using(v8));
create or replace view aggJoin2510168818489771270 as (
with aggView5192803380873423809 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView5192803380873423809 where mi_idx.info_type_id=aggView5192803380873423809.v26 and info>'7.0');
create or replace view aggJoin1024757006362155099 as (
with aggView7029580676070590198 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView7029580676070590198 where mi.info_type_id=aggView7029580676070590198.v21 and info IN ('Drama','Horror','Western','Family'));
create or replace view aggJoin7492186946037269789 as (
with aggView4079697951680083623 as (select v29 from aggJoin1024757006362155099 group by v29)
select v29, v27 from aggJoin2510168818489771270 join aggView4079697951680083623 using(v29));
create or replace view aggJoin8402057667796810075 as (
with aggView8792298714157461452 as (select v29, MIN(v27) as v42 from aggJoin7492186946037269789 group by v29)
select id as v29, title as v30, production_year as v33, v42 from title as t, aggView8792298714157461452 where t.id=aggView8792298714157461452.v29 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin2481780671867968647 as (
with aggView1385208776426657557 as (select v29, MIN(v42) as v42, MIN(v30) as v43 from aggJoin8402057667796810075 group by v29,v42)
select v41 as v41, v42, v43 from aggJoin8463533126893592696 join aggView1385208776426657557 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin2481780671867968647;
