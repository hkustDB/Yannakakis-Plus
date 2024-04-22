create or replace view aggJoin5787223231419428524 as (
with aggView245395219645718781 as (select id as v1, name as v41 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView245395219645718781 where mc.company_id=aggView245395219645718781.v1);
create or replace view aggJoin436584631331558734 as (
with aggView5978199021702580338 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin5787223231419428524 join aggView5978199021702580338 using(v8));
create or replace view aggJoin5808749654892022277 as (
with aggView5983991362651486128 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView5983991362651486128 where mi_idx.info_type_id=aggView5983991362651486128.v26 and info>'7.0');
create or replace view aggJoin7369681729503702996 as (
with aggView2818346769474138872 as (select v29, MIN(v27) as v42 from aggJoin5808749654892022277 group by v29)
select id as v29, title as v30, production_year as v33, v42 from title as t, aggView2818346769474138872 where t.id=aggView2818346769474138872.v29 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin3768129000889296467 as (
with aggView5238229919144795482 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView5238229919144795482 where mi.info_type_id=aggView5238229919144795482.v21 and info IN ('Drama','Horror','Western','Family'));
create or replace view aggJoin5550230816987600920 as (
with aggView9208529246226847484 as (select v29 from aggJoin3768129000889296467 group by v29)
select v29, v30, v33, v42 as v42 from aggJoin7369681729503702996 join aggView9208529246226847484 using(v29));
create or replace view aggJoin3667345255458345351 as (
with aggView3463035293360790900 as (select v29, MIN(v42) as v42, MIN(v30) as v43 from aggJoin5550230816987600920 group by v29,v42)
select v41 as v41, v42, v43 from aggJoin436584631331558734 join aggView3463035293360790900 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin3667345255458345351;
