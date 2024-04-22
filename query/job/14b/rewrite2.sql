create or replace view aggJoin2940138737135023139 as (
with aggView8179265239970819291 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView8179265239970819291 where t.kind_id=aggView8179265239970819291.v8 and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%')));
create or replace view aggJoin4484081827599918838 as (
with aggView7803101577372455596 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView7803101577372455596 where mi.info_type_id=aggView7803101577372455596.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin5901777945417338827 as (
with aggView7160516385419670486 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title'))
select movie_id as v23 from movie_keyword as mk, aggView7160516385419670486 where mk.keyword_id=aggView7160516385419670486.v5);
create or replace view aggJoin7635849331698413673 as (
with aggView9072489245287070626 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView9072489245287070626 where mi_idx.info_type_id=aggView9072489245287070626.v3);
create or replace view aggJoin7908217190187251531 as (
with aggView9207966681933460744 as (select v23, v18 from aggJoin7635849331698413673 group by v23,v18)
select v23, v18 from aggView9207966681933460744 where v18>'6.0');
create or replace view aggJoin5324845146569235113 as (
with aggView4950522177761782710 as (select v23 from aggJoin4484081827599918838 group by v23)
select v23 from aggJoin5901777945417338827 join aggView4950522177761782710 using(v23));
create or replace view aggJoin4687790953081334293 as (
with aggView552956340519353523 as (select v23 from aggJoin5324845146569235113 group by v23)
select v23, v24, v27 from aggJoin2940138737135023139 join aggView552956340519353523 using(v23));
create or replace view aggView3744202001412718069 as select v23, v24 from aggJoin4687790953081334293 group by v23,v24;
create or replace view aggJoin7268251342460605426 as (
with aggView1995353956973636067 as (select v23, MIN(v24) as v36 from aggView3744202001412718069 group by v23)
select v18, v36 from aggJoin7908217190187251531 join aggView1995353956973636067 using(v23));
select MIN(v18) as v35,MIN(v36) as v36 from aggJoin7268251342460605426;
