create or replace view aggJoin4757921643593451802 as (
with aggView6978614451749420540 as (select id as v8 from kind_type as kt where kind IN ('movie','episode'))
select id as v23, title as v24, production_year as v27 from title as t, aggView6978614451749420540 where t.kind_id=aggView6978614451749420540.v8 and production_year>2005);
create or replace view aggJoin308013203725173967 as (
with aggView3065307243113312996 as (select v23, MIN(v24) as v36 from aggJoin4757921643593451802 group by v23)
select movie_id as v23, info_type_id as v3, info as v18, v36 from movie_info_idx as mi_idx, aggView3065307243113312996 where mi_idx.movie_id=aggView3065307243113312996.v23 and info<'8.5');
create or replace view aggJoin2379589114855668052 as (
with aggView2545510921316239337 as (select id as v3 from info_type as it2 where info= 'rating')
select v23, v18, v36 from aggJoin308013203725173967 join aggView2545510921316239337 using(v3));
create or replace view aggJoin6028773118395761623 as (
with aggView2930671145146461634 as (select v23, MIN(v36) as v36, MIN(v18) as v35 from aggJoin2379589114855668052 group by v23,v36)
select movie_id as v23, info_type_id as v1, info as v13, v36, v35 from movie_info as mi, aggView2930671145146461634 where mi.movie_id=aggView2930671145146461634.v23 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin2619929172303134003 as (
with aggView4713023236894336588 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView4713023236894336588 where mk.keyword_id=aggView4713023236894336588.v5);
create or replace view aggJoin7403929594159844807 as (
with aggView8687982110004366082 as (select id as v1 from info_type as it1 where info= 'countries')
select v23, v13, v36, v35 from aggJoin6028773118395761623 join aggView8687982110004366082 using(v1));
create or replace view aggJoin5490769017081278908 as (
with aggView4285957677575230048 as (select v23, MIN(v36) as v36, MIN(v35) as v35 from aggJoin7403929594159844807 group by v23,v36,v35)
select v36, v35 from aggJoin2619929172303134003 join aggView4285957677575230048 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin5490769017081278908;
