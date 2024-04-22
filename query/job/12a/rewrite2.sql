create or replace view aggView4992303519678973486 as select name as v2, id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin4421989726909961118 as (
with aggView4810904084350941847 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView4810904084350941847 where mi.info_type_id=aggView4810904084350941847.v21 and info IN ('Drama','Horror'));
create or replace view aggJoin5615515797673853251 as (
with aggView417115136448833407 as (select v29 from aggJoin4421989726909961118 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView417115136448833407 where t.id=aggView417115136448833407.v29 and production_year<=2008 and production_year>=2005);
create or replace view aggView218012883307048410 as select v30, v29 from aggJoin5615515797673853251 group by v30,v29;
create or replace view aggJoin1724505132248516252 as (
with aggView370598448606067309 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView370598448606067309 where mi_idx.info_type_id=aggView370598448606067309.v26);
create or replace view aggJoin7542530629402303662 as (
with aggView6136177394521165304 as (select v27, v29 from aggJoin1724505132248516252 group by v27,v29)
select v29, v27 from aggView6136177394521165304 where v27>'8.0');
create or replace view aggJoin2780903577843976313 as (
with aggView4809746573402202982 as (select v1, MIN(v2) as v41 from aggView4992303519678973486 group by v1)
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView4809746573402202982 where mc.company_id=aggView4809746573402202982.v1);
create or replace view aggJoin2736446641993055725 as (
with aggView2602832355898268886 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin2780903577843976313 join aggView2602832355898268886 using(v8));
create or replace view aggJoin6891834972739583761 as (
with aggView5327488407624270648 as (select v29, MIN(v41) as v41 from aggJoin2736446641993055725 group by v29,v41)
select v30, v29, v41 from aggView218012883307048410 join aggView5327488407624270648 using(v29));
create or replace view aggJoin1713892400985036356 as (
with aggView7119535317297889212 as (select v29, MIN(v41) as v41, MIN(v30) as v43 from aggJoin6891834972739583761 group by v29,v41)
select v27, v41, v43 from aggJoin7542530629402303662 join aggView7119535317297889212 using(v29));
select MIN(v41) as v41,MIN(v27) as v42,MIN(v43) as v43 from aggJoin1713892400985036356;
