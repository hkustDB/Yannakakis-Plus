create or replace view aggJoin6066143066137851181 as (
with aggView5507234249497726328 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView5507234249497726328 where t.kind_id=aggView5507234249497726328.v21 and production_year>2000);
create or replace view aggJoin8775647516345757931 as (
with aggView5805492219099922369 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView5805492219099922369 where mc.company_type_id=aggView5805492219099922369.v14);
create or replace view aggJoin2643807096977598151 as (
with aggView5155107949199521040 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView5155107949199521040 where mi.info_type_id=aggView5155107949199521040.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin126614580215247231 as (
with aggView809675688087597228 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView809675688087597228 where mk.keyword_id=aggView809675688087597228.v18);
create or replace view aggJoin962527046581999998 as (
with aggView9139511071144644695 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView9139511071144644695 where cc.status_id=aggView9139511071144644695.v5);
create or replace view aggJoin1732080658569224122 as (
with aggView5734164408765973294 as (select v36 from aggJoin2643807096977598151 group by v36)
select v36 from aggJoin962527046581999998 join aggView5734164408765973294 using(v36));
create or replace view aggJoin7002848033528998055 as (
with aggView1807037205791837408 as (select v36 from aggJoin1732080658569224122 group by v36)
select v36, v7 from aggJoin8775647516345757931 join aggView1807037205791837408 using(v36));
create or replace view aggJoin4048569959785105511 as (
with aggView4163792549485919530 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin7002848033528998055 join aggView4163792549485919530 using(v7));
create or replace view aggJoin3335024509409338292 as (
with aggView4533210372569654310 as (select v36 from aggJoin4048569959785105511 group by v36)
select v36, v37, v40, v48 as v48 from aggJoin6066143066137851181 join aggView4533210372569654310 using(v36));
create or replace view aggJoin5571849908515050495 as (
with aggView755482520268073073 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin3335024509409338292 group by v36,v48)
select v48, v49 from aggJoin126614580215247231 join aggView755482520268073073 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin5571849908515050495;
