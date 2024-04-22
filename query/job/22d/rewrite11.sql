create or replace view aggJoin2107954823579111824 as (
with aggView6934738826074223022 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, v49 from movie_companies as mc, aggView6934738826074223022 where mc.company_id=aggView6934738826074223022.v1);
create or replace view aggJoin4641128987039812957 as (
with aggView4511409847513480277 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView4511409847513480277 where mi.info_type_id=aggView4511409847513480277.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin1979289040355367891 as (
with aggView8205136503156919424 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView8205136503156919424 where mk.keyword_id=aggView8205136503156919424.v14);
create or replace view aggJoin1983406690497044395 as (
with aggView1238840115070445675 as (select id as v8 from company_type as ct)
select v37, v49 from aggJoin2107954823579111824 join aggView1238840115070445675 using(v8));
create or replace view aggJoin6653220491243125348 as (
with aggView7216813505207618562 as (select v37, MIN(v49) as v49 from aggJoin1983406690497044395 group by v37,v49)
select v37, v27, v49 from aggJoin4641128987039812957 join aggView7216813505207618562 using(v37));
create or replace view aggJoin909580360878549264 as (
with aggView4674670219841696584 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView4674670219841696584 where mi_idx.info_type_id=aggView4674670219841696584.v12 and info<'8.5');
create or replace view aggJoin2325341485856749091 as (
with aggView1728537200397047757 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView1728537200397047757 where t.kind_id=aggView1728537200397047757.v17 and production_year>2005);
create or replace view aggJoin8746881302439078075 as (
with aggView7419559290442359442 as (select v37, MIN(v38) as v51 from aggJoin2325341485856749091 group by v37)
select v37, v27, v49 as v49, v51 from aggJoin6653220491243125348 join aggView7419559290442359442 using(v37));
create or replace view aggJoin1866877546875667811 as (
with aggView7851433144399444548 as (select v37, MIN(v49) as v49, MIN(v51) as v51 from aggJoin8746881302439078075 group by v37,v51,v49)
select v37, v32, v49, v51 from aggJoin909580360878549264 join aggView7851433144399444548 using(v37));
create or replace view aggJoin1332913543491964883 as (
with aggView4548748153881643096 as (select v37, MIN(v49) as v49, MIN(v51) as v51, MIN(v32) as v50 from aggJoin1866877546875667811 group by v37,v51,v49)
select v49, v51, v50 from aggJoin1979289040355367891 join aggView4548748153881643096 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin1332913543491964883;
