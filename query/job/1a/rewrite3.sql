create or replace view aggJoin4656955220070982985 as (
with aggView5577699067838603114 as (select id as v3 from info_type as it where info= 'top 250 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView5577699067838603114 where mi_idx.info_type_id=aggView5577699067838603114.v3);
create or replace view aggJoin7936645446812269775 as (
with aggView6861238182219706397 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView6861238182219706397 where mc.company_type_id=aggView6861238182219706397.v1 and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%')));
create or replace view aggJoin5720849068839030857 as (
with aggView2360148193027447370 as (select v15, v9 from aggJoin7936645446812269775 group by v15,v9)
select v15, v9 from aggView2360148193027447370 where v9 NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%');
create or replace view aggJoin9153624461816751650 as (
with aggView3122427541753124474 as (select v15 from aggJoin4656955220070982985 group by v15)
select id as v15, title as v16, production_year as v19 from title as t, aggView3122427541753124474 where t.id=aggView3122427541753124474.v15);
create or replace view aggView5030273842838456604 as select v19, v15, v16 from aggJoin9153624461816751650 group by v19,v15,v16;
create or replace view aggJoin8903676178109244280 as (
with aggView4566464930949159464 as (select v15, MIN(v16) as v28, MIN(v19) as v29 from aggView5030273842838456604 group by v15)
select v9, v28, v29 from aggJoin5720849068839030857 join aggView4566464930949159464 using(v15));
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin8903676178109244280;
