create or replace view aggJoin1054941781685151497 as (
with aggView2222596425112883627 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView2222596425112883627 where t.kind_id=aggView2222596425112883627.v8 and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%')));
create or replace view aggJoin3983090115411563279 as (
with aggView1061265394404374457 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView1061265394404374457 where mi_idx.info_type_id=aggView1061265394404374457.v3 and info>'6.0');
create or replace view aggJoin1194495660126386040 as (
with aggView6477762661930649458 as (select v23, MIN(v18) as v35 from aggJoin3983090115411563279 group by v23)
select v23, v24, v27, v35 from aggJoin1054941781685151497 join aggView6477762661930649458 using(v23));
create or replace view aggJoin3023510024502417327 as (
with aggView3974263808579926544 as (select v23, MIN(v35) as v35, MIN(v24) as v36 from aggJoin1194495660126386040 group by v23,v35)
select movie_id as v23, info_type_id as v1, info as v13, v35, v36 from movie_info as mi, aggView3974263808579926544 where mi.movie_id=aggView3974263808579926544.v23 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin6019142645050910218 as (
with aggView7815291669832801503 as (select id as v1 from info_type as it1 where info= 'countries')
select v23, v13, v35, v36 from aggJoin3023510024502417327 join aggView7815291669832801503 using(v1));
create or replace view aggJoin4186126746218898112 as (
with aggView80677418231081303 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title'))
select movie_id as v23 from movie_keyword as mk, aggView80677418231081303 where mk.keyword_id=aggView80677418231081303.v5);
create or replace view aggJoin6282745888634621215 as (
with aggView2866063852980965609 as (select v23, MIN(v35) as v35, MIN(v36) as v36 from aggJoin6019142645050910218 group by v23,v36,v35)
select v35, v36 from aggJoin4186126746218898112 join aggView2866063852980965609 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin6282745888634621215;
