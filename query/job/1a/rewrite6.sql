create or replace view aggJoin190625498222009307 as (
with aggView6369691287176820116 as (select id as v3 from info_type as it where info= 'top 250 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView6369691287176820116 where mi_idx.info_type_id=aggView6369691287176820116.v3);
create or replace view aggJoin1811143297077593464 as (
with aggView7753443361333118297 as (select v15 from aggJoin190625498222009307 group by v15)
select id as v15, title as v16, production_year as v19 from title as t, aggView7753443361333118297 where t.id=aggView7753443361333118297.v15);
create or replace view aggJoin7500663082482663 as (
with aggView3222535501938359759 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView3222535501938359759 where mc.company_type_id=aggView3222535501938359759.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%')));
create or replace view aggJoin6051468731240838033 as (
with aggView7773130984894778466 as (select v15, MIN(v9) as v27 from aggJoin7500663082482663 group by v15)
select v16, v19, v27 from aggJoin1811143297077593464 join aggView7773130984894778466 using(v15));
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin6051468731240838033;
