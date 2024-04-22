create or replace view aggJoin386064609092654300 as (
with aggView8997584928179221323 as (select id as v1, name as v41 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView8997584928179221323 where mc.company_id=aggView8997584928179221323.v1);
create or replace view aggJoin3681896498751993513 as (
with aggView5535428094504902089 as (select id as v29, title as v43 from title as t where production_year>=2000 and production_year<=2010)
select v29, v8, v41, v43 from aggJoin386064609092654300 join aggView5535428094504902089 using(v29));
create or replace view aggJoin282504960329087528 as (
with aggView2287660574312531224 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41, v43 from aggJoin3681896498751993513 join aggView2287660574312531224 using(v8));
create or replace view aggJoin423152363200453441 as (
with aggView8803963787596447667 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView8803963787596447667 where mi_idx.info_type_id=aggView8803963787596447667.v26 and info>'7.0');
create or replace view aggJoin6589180492951996720 as (
with aggView4669383270973885514 as (select v29, MIN(v27) as v42 from aggJoin423152363200453441 group by v29)
select movie_id as v29, info_type_id as v21, info as v22, v42 from movie_info as mi, aggView4669383270973885514 where mi.movie_id=aggView4669383270973885514.v29 and info IN ('Drama','Horror','Western','Family'));
create or replace view aggJoin179337377458734290 as (
with aggView1281626354748367107 as (select id as v21 from info_type as it1 where info= 'genres')
select v29, v22, v42 from aggJoin6589180492951996720 join aggView1281626354748367107 using(v21));
create or replace view aggJoin9092902732837513325 as (
with aggView449622525659110415 as (select v29, MIN(v42) as v42 from aggJoin179337377458734290 group by v29,v42)
select v41 as v41, v43 as v43, v42 from aggJoin282504960329087528 join aggView449622525659110415 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin9092902732837513325;
