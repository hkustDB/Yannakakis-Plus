create or replace view aggJoin1083392639270083176 as (
with aggView736279061885101644 as (select movie_id as v40, MIN(title) as v52 from aka_title as aka_t group by movie_id)
select id as v40, title as v41, production_year as v44, v52 from title as t, aggView736279061885101644 where t.id=aggView736279061885101644.v40 and production_year>1990);
create or replace view aggJoin5739212605377243634 as (
with aggView8043165972083913351 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView8043165972083913351 where mc.company_id=aggView8043165972083913351.v13);
create or replace view aggJoin1575849934155875087 as (
with aggView9196404286716658267 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, note as v36 from movie_info as mi, aggView9196404286716658267 where mi.info_type_id=aggView9196404286716658267.v22 and note LIKE '%internet%');
create or replace view aggJoin3304319325416421262 as (
with aggView5002005925016147915 as (select v40 from aggJoin1575849934155875087 group by v40)
select v40, v41, v44, v52 as v52 from aggJoin1083392639270083176 join aggView5002005925016147915 using(v40));
create or replace view aggJoin1920231911402601870 as (
with aggView2056236004659808816 as (select v40, MIN(v52) as v52, MIN(v41) as v53 from aggJoin3304319325416421262 group by v40,v52)
select movie_id as v40, keyword_id as v24, v52, v53 from movie_keyword as mk, aggView2056236004659808816 where mk.movie_id=aggView2056236004659808816.v40);
create or replace view aggJoin6984830707229010128 as (
with aggView5385762017830609839 as (select id as v20 from company_type as ct)
select v40 from aggJoin5739212605377243634 join aggView5385762017830609839 using(v20));
create or replace view aggJoin3758039313506316442 as (
with aggView7457839491072163432 as (select v40 from aggJoin6984830707229010128 group by v40)
select v24, v52 as v52, v53 as v53 from aggJoin1920231911402601870 join aggView7457839491072163432 using(v40));
create or replace view aggJoin5767498629206441860 as (
with aggView2640830257214479193 as (select id as v24 from keyword as k)
select v52, v53 from aggJoin3758039313506316442 join aggView2640830257214479193 using(v24));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin5767498629206441860;
