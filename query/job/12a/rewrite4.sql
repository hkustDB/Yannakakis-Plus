create or replace view aggView6484896171574171167 as select name as v2, id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggView4254121055815953597 as select title as v30, id as v29 from title as t where production_year<=2008 and production_year>=2005;
create or replace view aggJoin414552681936695144 as (
with aggView1701747211365654998 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView1701747211365654998 where mi.info_type_id=aggView1701747211365654998.v21 and info IN ('Drama','Horror'));
create or replace view aggJoin5886417103779054395 as (
with aggView1849854800588117055 as (select v29 from aggJoin414552681936695144 group by v29)
select movie_id as v29, info_type_id as v26, info as v27 from movie_info_idx as mi_idx, aggView1849854800588117055 where mi_idx.movie_id=aggView1849854800588117055.v29);
create or replace view aggJoin2622441733382330847 as (
with aggView8895979327740517263 as (select id as v26 from info_type as it2 where info= 'rating')
select v29, v27 from aggJoin5886417103779054395 join aggView8895979327740517263 using(v26));
create or replace view aggJoin1577686310496803378 as (
with aggView7153287578978101131 as (select v27, v29 from aggJoin2622441733382330847 group by v27,v29)
select v29, v27 from aggView7153287578978101131 where v27>'8.0');
create or replace view aggJoin4115680392062149670 as (
with aggView2520464527413927459 as (select v29, MIN(v27) as v42 from aggJoin1577686310496803378 group by v29)
select movie_id as v29, company_id as v1, company_type_id as v8, v42 from movie_companies as mc, aggView2520464527413927459 where mc.movie_id=aggView2520464527413927459.v29);
create or replace view aggJoin130454014512460686 as (
with aggView3695775019573139345 as (select v29, MIN(v30) as v43 from aggView4254121055815953597 group by v29)
select v1, v8, v42 as v42, v43 from aggJoin4115680392062149670 join aggView3695775019573139345 using(v29));
create or replace view aggJoin3881873739859503155 as (
with aggView8416810069489891413 as (select id as v8 from company_type as ct where kind= 'production companies')
select v1, v42, v43 from aggJoin130454014512460686 join aggView8416810069489891413 using(v8));
create or replace view aggJoin3814558038998419451 as (
with aggView6477666741969055010 as (select v1, MIN(v42) as v42, MIN(v43) as v43 from aggJoin3881873739859503155 group by v1,v43,v42)
select v2, v42, v43 from aggView6484896171574171167 join aggView6477666741969055010 using(v1));
select MIN(v2) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin3814558038998419451;
