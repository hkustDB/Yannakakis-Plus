create or replace view aggView3433055769172501322 as select title as v32, id as v31 from title as t where production_year>=2008 and production_year<=2014;
create or replace view aggJoin6842204347855958161 as (
with aggView8261767157920078902 as (select id as v22 from name as n where gender= 'f')
select movie_id as v31, note as v5 from cast_info as ci, aggView8261767157920078902 where ci.person_id=aggView8261767157920078902.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5075756370428566022 as (
with aggView1817193311123938109 as (select v31 from aggJoin6842204347855958161 group by v31)
select movie_id as v31, info_type_id as v10, info as v20 from movie_info_idx as mi_idx, aggView1817193311123938109 where mi_idx.movie_id=aggView1817193311123938109.v31);
create or replace view aggJoin8684410579846226781 as (
with aggView5273055457090350655 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView5273055457090350655 where mi.info_type_id=aggView5273055457090350655.v8 and info IN ('Horror','Thriller'));
create or replace view aggView2683348513179677414 as select v15, v31 from aggJoin8684410579846226781 group by v15,v31;
create or replace view aggJoin4913130583373015102 as (
with aggView6873166801508416581 as (select id as v10 from info_type as it2 where info= 'rating')
select v31, v20 from aggJoin5075756370428566022 join aggView6873166801508416581 using(v10));
create or replace view aggJoin1222402620288011670 as (
with aggView7548188877500422034 as (select v31, v20 from aggJoin4913130583373015102 group by v31,v20)
select v31, v20 from aggView7548188877500422034 where v20>'8.0');
create or replace view aggJoin5530514133269685173 as (
with aggView1917492091586734791 as (select v31, MIN(v32) as v45 from aggView3433055769172501322 group by v31)
select v15, v31, v45 from aggView2683348513179677414 join aggView1917492091586734791 using(v31));
create or replace view aggJoin7233078521800586919 as (
with aggView1024973773415091261 as (select v31, MIN(v45) as v45, MIN(v15) as v43 from aggJoin5530514133269685173 group by v31,v45)
select v20, v45, v43 from aggJoin1222402620288011670 join aggView1024973773415091261 using(v31));
select MIN(v43) as v43,MIN(v20) as v44,MIN(v45) as v45 from aggJoin7233078521800586919;
