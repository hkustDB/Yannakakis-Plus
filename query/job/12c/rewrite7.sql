create or replace view aggView3082826187126147544 as select id as v29, title as v30 from title as t where production_year>=2000 and production_year<=2010;
create or replace view aggView8392043468476858708 as select name as v2, id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin2816287017273916137 as (
with aggView6132761847705444456 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView6132761847705444456 where mi_idx.info_type_id=aggView6132761847705444456.v26);
create or replace view aggJoin8527850503910157858 as (
with aggView4863092237316366711 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView4863092237316366711 where mi.info_type_id=aggView4863092237316366711.v21 and info IN ('Drama','Horror','Western','Family'));
create or replace view aggJoin7163711146633247807 as (
with aggView5513337186584592802 as (select v29 from aggJoin8527850503910157858 group by v29)
select v29, v27 from aggJoin2816287017273916137 join aggView5513337186584592802 using(v29));
create or replace view aggJoin8999542462706063664 as (
with aggView2985536057711458230 as (select v29, v27 from aggJoin7163711146633247807 group by v29,v27)
select v29, v27 from aggView2985536057711458230 where v27>'7.0');
create or replace view aggJoin3981447591632835525 as (
with aggView2021469943238800024 as (select v29, MIN(v27) as v42 from aggJoin8999542462706063664 group by v29)
select movie_id as v29, company_id as v1, company_type_id as v8, v42 from movie_companies as mc, aggView2021469943238800024 where mc.movie_id=aggView2021469943238800024.v29);
create or replace view aggJoin8947396467987042068 as (
with aggView2583834983117354422 as (select v29, MIN(v30) as v43 from aggView3082826187126147544 group by v29)
select v1, v8, v42 as v42, v43 from aggJoin3981447591632835525 join aggView2583834983117354422 using(v29));
create or replace view aggJoin232457502485872237 as (
with aggView822166476471690694 as (select id as v8 from company_type as ct where kind= 'production companies')
select v1, v42, v43 from aggJoin8947396467987042068 join aggView822166476471690694 using(v8));
create or replace view aggJoin236440069265079268 as (
with aggView760327239457736657 as (select v1, MIN(v42) as v42, MIN(v43) as v43 from aggJoin232457502485872237 group by v1,v42,v43)
select v2, v42, v43 from aggView8392043468476858708 join aggView760327239457736657 using(v1));
select MIN(v2) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin236440069265079268;
