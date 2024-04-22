create or replace view aggJoin4346426538853444284 as (
with aggView1794126531637995911 as (select id as v3 from info_type as it where info= 'top 250 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView1794126531637995911 where mi_idx.info_type_id=aggView1794126531637995911.v3);
create or replace view aggJoin8061742204100714861 as (
with aggView5791015374706866971 as (select v15 from aggJoin4346426538853444284 group by v15)
select id as v15, title as v16, production_year as v19 from title as t, aggView5791015374706866971 where t.id=aggView5791015374706866971.v15);
create or replace view aggJoin876435505990617114 as (
with aggView6287139252860626474 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView6287139252860626474 where mc.company_type_id=aggView6287139252860626474.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%')));
create or replace view aggJoin5961998555175262528 as (
with aggView6230256007378659469 as (select v15, MIN(v9) as v27 from aggJoin876435505990617114 group by v15)
select v16, v19, v27 from aggJoin8061742204100714861 join aggView6230256007378659469 using(v15));
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin5961998555175262528;
