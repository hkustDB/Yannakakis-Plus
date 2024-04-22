create or replace view aggView7185294047870777434 as select title as v44, id as v11 from title as t where episode_nr>=5 and episode_nr<100;
create or replace view aggJoin6303665291492440526 as (
with aggView7239029460127645387 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView7239029460127645387 where an.person_id=aggView7239029460127645387.v2);
create or replace view aggView1722962250351467656 as select v2, v3 from aggJoin6303665291492440526 group by v2,v3;
create or replace view aggJoin6699605954712541217 as (
with aggView3291486481367481650 as (select v2, MIN(v3) as v55 from aggView1722962250351467656 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView3291486481367481650 where ci.person_id=aggView3291486481367481650.v2);
create or replace view aggJoin5673222533092699730 as (
with aggView6348611763870282646 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView6348611763870282646 where mc.company_id=aggView6348611763870282646.v28);
create or replace view aggJoin4990109372590957121 as (
with aggView526263354726218473 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView526263354726218473 where mk.keyword_id=aggView526263354726218473.v33);
create or replace view aggJoin4718825654238987954 as (
with aggView3304255052397296305 as (select v11 from aggJoin5673222533092699730 group by v11)
select v11 from aggJoin4990109372590957121 join aggView3304255052397296305 using(v11));
create or replace view aggJoin4878345547316933662 as (
with aggView4609067771455495387 as (select v11 from aggJoin4718825654238987954 group by v11)
select v11, v55 as v55 from aggJoin6699605954712541217 join aggView4609067771455495387 using(v11));
create or replace view aggJoin7681346213891786353 as (
with aggView4942614406712618250 as (select v11, MIN(v55) as v55 from aggJoin4878345547316933662 group by v11,v55)
select v44, v55 from aggView7185294047870777434 join aggView4942614406712618250 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin7681346213891786353;
