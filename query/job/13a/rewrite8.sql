create or replace view aggJoin2408799759371789786 as (
with aggView1203676888014301291 as (select id as v8 from company_type as ct where kind= 'production companies')
select movie_id as v22, company_id as v1 from movie_companies as mc, aggView1203676888014301291 where mc.company_type_id=aggView1203676888014301291.v8);
create or replace view aggJoin4314789837241758105 as (
with aggView8573470795411687245 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView8573470795411687245 where miidx.info_type_id=aggView8573470795411687245.v10);
create or replace view aggView3186567831402144537 as select v22, v29 from aggJoin4314789837241758105 group by v22,v29;
create or replace view aggJoin49694429845520685 as (
with aggView6886353425613249180 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22, info as v24 from movie_info as mi, aggView6886353425613249180 where mi.info_type_id=aggView6886353425613249180.v12);
create or replace view aggView2236353059283324068 as select v24, v22 from aggJoin49694429845520685 group by v24,v22;
create or replace view aggJoin638527611425014314 as (
with aggView536956185795167936 as (select id as v1 from company_name as cn where country_code= '[de]')
select v22 from aggJoin2408799759371789786 join aggView536956185795167936 using(v1));
create or replace view aggJoin6507120463951030283 as (
with aggView4352042213182115393 as (select v22 from aggJoin638527611425014314 group by v22)
select id as v22, title as v32, kind_id as v14 from title as t, aggView4352042213182115393 where t.id=aggView4352042213182115393.v22);
create or replace view aggJoin5291147704919228463 as (
with aggView2314009641319248554 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32 from aggJoin6507120463951030283 join aggView2314009641319248554 using(v14));
create or replace view aggView8537999143899063797 as select v22, v32 from aggJoin5291147704919228463 group by v22,v32;
create or replace view aggJoin4232328308487206599 as (
with aggView9105148276270700473 as (select v22, MIN(v29) as v44 from aggView3186567831402144537 group by v22)
select v22, v32, v44 from aggView8537999143899063797 join aggView9105148276270700473 using(v22));
create or replace view aggJoin8522035096195820301 as (
with aggView8775935660561142822 as (select v22, MIN(v44) as v44, MIN(v32) as v45 from aggJoin4232328308487206599 group by v22,v44)
select v24, v44, v45 from aggView2236353059283324068 join aggView8775935660561142822 using(v22));
select MIN(v24) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin8522035096195820301;
