create or replace view aggJoin6988475204621712940 as (
with aggView994513117935396025 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView994513117935396025 where mk.keyword_id=aggView994513117935396025.v5);
create or replace view aggJoin1962162742473121939 as (
with aggView767846358231465695 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView767846358231465695 where mi_idx.info_type_id=aggView767846358231465695.v3);
create or replace view aggJoin3496048595431222300 as (
with aggView2806953780709833571 as (select id as v8 from kind_type as kt where kind IN ('movie','episode'))
select id as v23, title as v24, production_year as v27 from title as t, aggView2806953780709833571 where t.kind_id=aggView2806953780709833571.v8 and production_year>2005);
create or replace view aggView4343770594318462333 as select v24, v23 from aggJoin3496048595431222300 group by v24,v23;
create or replace view aggJoin1274063662238045674 as (
with aggView617732121275207461 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView617732121275207461 where mi.info_type_id=aggView617732121275207461.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin1468717073835828392 as (
with aggView276274203033413143 as (select v23 from aggJoin6988475204621712940 group by v23)
select v23, v13 from aggJoin1274063662238045674 join aggView276274203033413143 using(v23));
create or replace view aggJoin3982853347669131213 as (
with aggView8160055979888715955 as (select v23 from aggJoin1468717073835828392 group by v23)
select v23, v18 from aggJoin1962162742473121939 join aggView8160055979888715955 using(v23));
create or replace view aggJoin1929735732688063562 as (
with aggView4327120249553914462 as (select v18, v23 from aggJoin3982853347669131213 group by v18,v23)
select v23, v18 from aggView4327120249553914462 where v18<'8.5');
create or replace view aggJoin2260518724968835584 as (
with aggView361268488492737554 as (select v23, MIN(v18) as v35 from aggJoin1929735732688063562 group by v23)
select v24, v35 from aggView4343770594318462333 join aggView361268488492737554 using(v23));
select MIN(v35) as v35,MIN(v24) as v36 from aggJoin2260518724968835584;
