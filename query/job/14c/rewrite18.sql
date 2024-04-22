create or replace view aggJoin7407603266369447165 as (
with aggView2716569180217381491 as (select id as v8 from kind_type as kt where kind IN ('movie','episode'))
select id as v23, title as v24, production_year as v27 from title as t, aggView2716569180217381491 where t.kind_id=aggView2716569180217381491.v8 and production_year>2005);
create or replace view aggJoin785789913802699223 as (
with aggView5610024063843326477 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView5610024063843326477 where mi_idx.info_type_id=aggView5610024063843326477.v3 and info<'8.5');
create or replace view aggJoin935779133081334010 as (
with aggView7968643981549387195 as (select v23, MIN(v18) as v35 from aggJoin785789913802699223 group by v23)
select v23, v24, v27, v35 from aggJoin7407603266369447165 join aggView7968643981549387195 using(v23));
create or replace view aggJoin1269564290862490722 as (
with aggView879829147325715789 as (select v23, MIN(v35) as v35, MIN(v24) as v36 from aggJoin935779133081334010 group by v23,v35)
select movie_id as v23, keyword_id as v5, v35, v36 from movie_keyword as mk, aggView879829147325715789 where mk.movie_id=aggView879829147325715789.v23);
create or replace view aggJoin2875344629823394060 as (
with aggView1273370278927715911 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v23, v35, v36 from aggJoin1269564290862490722 join aggView1273370278927715911 using(v5));
create or replace view aggJoin5010161026332946662 as (
with aggView4795420715951155645 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView4795420715951155645 where mi.info_type_id=aggView4795420715951155645.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin7589653718869043453 as (
with aggView964446690924330087 as (select v23 from aggJoin5010161026332946662 group by v23)
select v35 as v35, v36 as v36 from aggJoin2875344629823394060 join aggView964446690924330087 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin7589653718869043453;
