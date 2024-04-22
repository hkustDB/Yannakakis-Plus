create or replace view aggJoin895423315709408559 as (
with aggView4817412581843709317 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView4817412581843709317 where t.kind_id=aggView4817412581843709317.v8 and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%')));
create or replace view aggJoin6258497618300011370 as (
with aggView934295762094950 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView934295762094950 where mi_idx.info_type_id=aggView934295762094950.v3);
create or replace view aggJoin7651785223428898726 as (
with aggView593292759735338770 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title'))
select movie_id as v23 from movie_keyword as mk, aggView593292759735338770 where mk.keyword_id=aggView593292759735338770.v5);
create or replace view aggJoin9016403605744912176 as (
with aggView1713521727949480943 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView1713521727949480943 where mi.info_type_id=aggView1713521727949480943.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin2227804418618072292 as (
with aggView6794190815519061025 as (select v23 from aggJoin7651785223428898726 group by v23)
select v23, v18 from aggJoin6258497618300011370 join aggView6794190815519061025 using(v23));
create or replace view aggJoin24493170713594246 as (
with aggView4574672132488143260 as (select v23, v18 from aggJoin2227804418618072292 group by v23,v18)
select v23, v18 from aggView4574672132488143260 where v18>'6.0');
create or replace view aggJoin8328003883483794818 as (
with aggView8245532149135594268 as (select v23 from aggJoin9016403605744912176 group by v23)
select v23, v24, v27 from aggJoin895423315709408559 join aggView8245532149135594268 using(v23));
create or replace view aggView7572371190609903634 as select v23, v24 from aggJoin8328003883483794818 group by v23,v24;
create or replace view aggJoin8136383921505250880 as (
with aggView1506824214987153224 as (select v23, MIN(v18) as v35 from aggJoin24493170713594246 group by v23)
select v24, v35 from aggView7572371190609903634 join aggView1506824214987153224 using(v23));
select MIN(v35) as v35,MIN(v24) as v36 from aggJoin8136383921505250880;
