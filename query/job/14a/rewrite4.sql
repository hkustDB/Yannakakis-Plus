create or replace view aggJoin4310649768397487552 as (
with aggView300104162399421357 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView300104162399421357 where mi_idx.info_type_id=aggView300104162399421357.v3);
create or replace view aggJoin6283045629364317333 as (
with aggView4842396659722041210 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView4842396659722041210 where mi.info_type_id=aggView4842396659722041210.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin4939169627140317450 as (
with aggView2058299708582924563 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView2058299708582924563 where mk.keyword_id=aggView2058299708582924563.v5);
create or replace view aggJoin51468261854403277 as (
with aggView7293951343104918344 as (select v23 from aggJoin4939169627140317450 group by v23)
select id as v23, title as v24, kind_id as v8, production_year as v27 from title as t, aggView7293951343104918344 where t.id=aggView7293951343104918344.v23 and production_year>2010);
create or replace view aggJoin317906383034714280 as (
with aggView8210109767321256652 as (select v23 from aggJoin6283045629364317333 group by v23)
select v23, v18 from aggJoin4310649768397487552 join aggView8210109767321256652 using(v23));
create or replace view aggJoin7080655804281719841 as (
with aggView5561168702173386594 as (select v23, v18 from aggJoin317906383034714280 group by v23,v18)
select v23, v18 from aggView5561168702173386594 where v18<'8.5');
create or replace view aggJoin2689342277574663925 as (
with aggView2733503134774409145 as (select id as v8 from kind_type as kt where kind= 'movie')
select v23, v24, v27 from aggJoin51468261854403277 join aggView2733503134774409145 using(v8));
create or replace view aggView2068740398690510142 as select v23, v24 from aggJoin2689342277574663925 group by v23,v24;
create or replace view aggJoin5746444301977281736 as (
with aggView5450093792859091293 as (select v23, MIN(v18) as v35 from aggJoin7080655804281719841 group by v23)
select v24, v35 from aggView2068740398690510142 join aggView5450093792859091293 using(v23));
select MIN(v35) as v35,MIN(v24) as v36 from aggJoin5746444301977281736;
