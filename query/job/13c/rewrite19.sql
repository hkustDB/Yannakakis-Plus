create or replace view aggJoin2631930576517183173 as (
with aggView2728396244144224787 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView2728396244144224787 where mc.company_id=aggView2728396244144224787.v1);
create or replace view aggJoin4252274156786358957 as (
with aggView8782900155100253114 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin2631930576517183173 join aggView8782900155100253114 using(v8));
create or replace view aggJoin2454389065616705087 as (
with aggView2452779478173094407 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView2452779478173094407 where miidx.info_type_id=aggView2452779478173094407.v10);
create or replace view aggJoin9067121547252563683 as (
with aggView4401065489576123081 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView4401065489576123081 where mi.info_type_id=aggView4401065489576123081.v12);
create or replace view aggJoin3154169439065871132 as (
with aggView5157973585812672106 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView5157973585812672106 where t.kind_id=aggView5157973585812672106.v14 and title<> '' and ((title LIKE 'Champion%') OR (title LIKE 'Loser%')));
create or replace view aggJoin7599261219571313312 as (
with aggView5510520148483770316 as (select v22, MIN(v32) as v45 from aggJoin3154169439065871132 group by v22)
select v22, v29, v45 from aggJoin2454389065616705087 join aggView5510520148483770316 using(v22));
create or replace view aggJoin4279759706565566392 as (
with aggView7272261368452522457 as (select v22, MIN(v43) as v43 from aggJoin4252274156786358957 group by v22,v43)
select v22, v29, v45 as v45, v43 from aggJoin7599261219571313312 join aggView7272261368452522457 using(v22));
create or replace view aggJoin3663738960741521007 as (
with aggView5001562717482385275 as (select v22, MIN(v45) as v45, MIN(v43) as v43, MIN(v29) as v44 from aggJoin4279759706565566392 group by v22,v45,v43)
select v45, v43, v44 from aggJoin9067121547252563683 join aggView5001562717482385275 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin3663738960741521007;
