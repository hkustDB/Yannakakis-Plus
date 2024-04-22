create or replace view aggJoin1951009549279949252 as (
with aggView2171280928859102465 as (select id as v29, title as v43 from title as t where production_year>=2000 and production_year<=2010)
select movie_id as v29, info_type_id as v21, info as v22, v43 from movie_info as mi, aggView2171280928859102465 where mi.movie_id=aggView2171280928859102465.v29 and info IN ('Drama','Horror','Western','Family'));
create or replace view aggJoin8708235862092128730 as (
with aggView3925036200073959216 as (select id as v1, name as v41 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView3925036200073959216 where mc.company_id=aggView3925036200073959216.v1);
create or replace view aggJoin702455866455002402 as (
with aggView2826439385509622963 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin8708235862092128730 join aggView2826439385509622963 using(v8));
create or replace view aggJoin1926453727871870614 as (
with aggView3051805171502441015 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView3051805171502441015 where mi_idx.info_type_id=aggView3051805171502441015.v26 and info>'7.0');
create or replace view aggJoin3945566800385961975 as (
with aggView2034783652419261610 as (select id as v21 from info_type as it1 where info= 'genres')
select v29, v22, v43 from aggJoin1951009549279949252 join aggView2034783652419261610 using(v21));
create or replace view aggJoin8529799338084626031 as (
with aggView3866184345577509403 as (select v29, MIN(v43) as v43 from aggJoin3945566800385961975 group by v29,v43)
select v29, v27, v43 from aggJoin1926453727871870614 join aggView3866184345577509403 using(v29));
create or replace view aggJoin4432022838857946291 as (
with aggView3033672518806564325 as (select v29, MIN(v43) as v43, MIN(v27) as v42 from aggJoin8529799338084626031 group by v29,v43)
select v41 as v41, v43, v42 from aggJoin702455866455002402 join aggView3033672518806564325 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin4432022838857946291;
