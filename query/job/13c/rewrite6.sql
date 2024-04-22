create or replace view aggView4435160288035760670 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin2391911058464641424 as (
with aggView7796757928501549961 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView7796757928501549961 where miidx.info_type_id=aggView7796757928501549961.v10);
create or replace view aggView3391760542944323512 as select v22, v29 from aggJoin2391911058464641424 group by v22,v29;
create or replace view aggJoin1328371107381760023 as (
with aggView4884921541763019304 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView4884921541763019304 where t.kind_id=aggView4884921541763019304.v14 and title<> '' and ((title LIKE 'Champion%') OR (title LIKE 'Loser%')));
create or replace view aggView6251442942077975428 as select v32, v22 from aggJoin1328371107381760023 group by v32,v22;
create or replace view aggJoin2405699756331562230 as (
with aggView3134979055581414758 as (select v22, MIN(v32) as v45 from aggView6251442942077975428 group by v22)
select v22, v29, v45 from aggView3391760542944323512 join aggView3134979055581414758 using(v22));
create or replace view aggJoin7851167683605533572 as (
with aggView5743733273213925763 as (select v22, MIN(v45) as v45, MIN(v29) as v44 from aggJoin2405699756331562230 group by v22,v45)
select movie_id as v22, company_id as v1, company_type_id as v8, v45, v44 from movie_companies as mc, aggView5743733273213925763 where mc.movie_id=aggView5743733273213925763.v22);
create or replace view aggJoin9128173490081876932 as (
with aggView4069184977292146414 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v1, v45, v44 from aggJoin7851167683605533572 join aggView4069184977292146414 using(v8));
create or replace view aggJoin3790377524136508734 as (
with aggView6847424383843082712 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView6847424383843082712 where mi.info_type_id=aggView6847424383843082712.v12);
create or replace view aggJoin4744926024589415722 as (
with aggView8035602376683890244 as (select v22 from aggJoin3790377524136508734 group by v22)
select v1, v45 as v45, v44 as v44 from aggJoin9128173490081876932 join aggView8035602376683890244 using(v22));
create or replace view aggJoin8370856822568320499 as (
with aggView3414601257832888540 as (select v1, MIN(v45) as v45, MIN(v44) as v44 from aggJoin4744926024589415722 group by v1,v45,v44)
select v2, v45, v44 from aggView4435160288035760670 join aggView3414601257832888540 using(v1));
select MIN(v2) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin8370856822568320499;
