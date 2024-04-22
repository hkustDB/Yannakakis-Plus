create or replace view aggJoin4007694236752922790 as (
with aggView5157502539559228490 as (select id as v8 from kind_type as kt where kind IN ('movie','episode'))
select id as v23, title as v24, production_year as v27 from title as t, aggView5157502539559228490 where t.kind_id=aggView5157502539559228490.v8 and production_year>2005);
create or replace view aggJoin158371667955477011 as (
with aggView4671047368674669679 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView4671047368674669679 where mi_idx.info_type_id=aggView4671047368674669679.v3 and info<'8.5');
create or replace view aggJoin4174081283709902863 as (
with aggView795958291874768774 as (select v23, MIN(v18) as v35 from aggJoin158371667955477011 group by v23)
select movie_id as v23, keyword_id as v5, v35 from movie_keyword as mk, aggView795958291874768774 where mk.movie_id=aggView795958291874768774.v23);
create or replace view aggJoin6102351960017707027 as (
with aggView6853716324201408414 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v23, v35 from aggJoin4174081283709902863 join aggView6853716324201408414 using(v5));
create or replace view aggJoin3285584088233888899 as (
with aggView4808948583084146009 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView4808948583084146009 where mi.info_type_id=aggView4808948583084146009.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin6607621842269633585 as (
with aggView9016457633875687370 as (select v23 from aggJoin3285584088233888899 group by v23)
select v23, v24, v27 from aggJoin4007694236752922790 join aggView9016457633875687370 using(v23));
create or replace view aggJoin3790419715521864798 as (
with aggView4767216535442594472 as (select v23, MIN(v24) as v36 from aggJoin6607621842269633585 group by v23)
select v35 as v35, v36 from aggJoin6102351960017707027 join aggView4767216535442594472 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin3790419715521864798;
