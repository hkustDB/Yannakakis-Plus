create or replace view aggJoin5678194190525997466 as (
with aggView4396479781816120348 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView4396479781816120348 where mc.company_type_id=aggView4396479781816120348.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%')));
create or replace view aggJoin6204622354487814046 as (
with aggView4310688738527092454 as (select v15, MIN(v9) as v27 from aggJoin5678194190525997466 group by v15)
select movie_id as v15, info_type_id as v3, v27 from movie_info_idx as mi_idx, aggView4310688738527092454 where mi_idx.movie_id=aggView4310688738527092454.v15);
create or replace view aggJoin1093771696899817943 as (
with aggView2533128705973839069 as (select id as v3 from info_type as it where info= 'top 250 rank')
select v15, v27 from aggJoin6204622354487814046 join aggView2533128705973839069 using(v3));
create or replace view aggJoin7507871680043497184 as (
with aggView7415742905758031494 as (select v15, MIN(v27) as v27 from aggJoin1093771696899817943 group by v15,v27)
select title as v16, production_year as v19, v27 from title as t, aggView7415742905758031494 where t.id=aggView7415742905758031494.v15);
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin7507871680043497184;
