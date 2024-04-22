create or replace view aggJoin4505845408447586094 as (
with aggView1610296052058934178 as (select id as v8 from kind_type as kt where kind IN ('movie','episode'))
select id as v23, title as v24, production_year as v27 from title as t, aggView1610296052058934178 where t.kind_id=aggView1610296052058934178.v8 and production_year>2005);
create or replace view aggView4379994940831883137 as select v24, v23 from aggJoin4505845408447586094 group by v24,v23;
create or replace view aggJoin8036725605153294925 as (
with aggView736930068737562048 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView736930068737562048 where mk.keyword_id=aggView736930068737562048.v5);
create or replace view aggJoin6572926310706052724 as (
with aggView2529217649985001794 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView2529217649985001794 where mi_idx.info_type_id=aggView2529217649985001794.v3);
create or replace view aggJoin694614754448876815 as (
with aggView1772123266085795377 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView1772123266085795377 where mi.info_type_id=aggView1772123266085795377.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin9021977302397021254 as (
with aggView690506801509391263 as (select v23 from aggJoin694614754448876815 group by v23)
select v23 from aggJoin8036725605153294925 join aggView690506801509391263 using(v23));
create or replace view aggJoin8839825128399232182 as (
with aggView1122854142459595452 as (select v23 from aggJoin9021977302397021254 group by v23)
select v23, v18 from aggJoin6572926310706052724 join aggView1122854142459595452 using(v23));
create or replace view aggJoin5225745751032359463 as (
with aggView6957507888106731636 as (select v18, v23 from aggJoin8839825128399232182 group by v18,v23)
select v23, v18 from aggView6957507888106731636 where v18<'8.5');
create or replace view aggJoin4264801362604660038 as (
with aggView685793226496677021 as (select v23, MIN(v24) as v36 from aggView4379994940831883137 group by v23)
select v18, v36 from aggJoin5225745751032359463 join aggView685793226496677021 using(v23));
select MIN(v18) as v35,MIN(v36) as v36 from aggJoin4264801362604660038;
