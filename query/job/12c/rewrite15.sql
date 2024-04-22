create or replace view aggJoin6735866813429157362 as (
with aggView8280381784834114428 as (select id as v29, title as v43 from title as t where production_year>=2000 and production_year<=2010)
select movie_id as v29, info_type_id as v26, info as v27, v43 from movie_info_idx as mi_idx, aggView8280381784834114428 where mi_idx.movie_id=aggView8280381784834114428.v29 and info>'7.0');
create or replace view aggJoin1896975142417302528 as (
with aggView7360401988120862014 as (select id as v1, name as v41 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView7360401988120862014 where mc.company_id=aggView7360401988120862014.v1);
create or replace view aggJoin7264737726838929858 as (
with aggView8780499183403977878 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin1896975142417302528 join aggView8780499183403977878 using(v8));
create or replace view aggJoin1839092421591073817 as (
with aggView7093644326809749682 as (select id as v26 from info_type as it2 where info= 'rating')
select v29, v27, v43 from aggJoin6735866813429157362 join aggView7093644326809749682 using(v26));
create or replace view aggJoin2498933496216684628 as (
with aggView6021795220570441206 as (select v29, MIN(v43) as v43, MIN(v27) as v42 from aggJoin1839092421591073817 group by v29,v43)
select movie_id as v29, info_type_id as v21, info as v22, v43, v42 from movie_info as mi, aggView6021795220570441206 where mi.movie_id=aggView6021795220570441206.v29 and info IN ('Drama','Horror','Western','Family'));
create or replace view aggJoin8019940754466876733 as (
with aggView4769756203345289458 as (select id as v21 from info_type as it1 where info= 'genres')
select v29, v22, v43, v42 from aggJoin2498933496216684628 join aggView4769756203345289458 using(v21));
create or replace view aggJoin6432869309604105047 as (
with aggView467308115199551254 as (select v29, MIN(v43) as v43, MIN(v42) as v42 from aggJoin8019940754466876733 group by v29,v42,v43)
select v41 as v41, v43, v42 from aggJoin7264737726838929858 join aggView467308115199551254 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin6432869309604105047;
