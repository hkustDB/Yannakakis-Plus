create or replace view aggView7631483939862216047 as select title as v32, id as v31 from title as t;
create or replace view aggJoin7596330239920809004 as (
with aggView4300068898299459915 as (select id as v22 from name as n where gender= 'm')
select movie_id as v31, note as v5 from cast_info as ci, aggView4300068898299459915 where ci.person_id=aggView4300068898299459915.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin242792709279769810 as (
with aggView6988269965609471331 as (select v31 from aggJoin7596330239920809004 group by v31)
select movie_id as v31, info_type_id as v10, info as v20 from movie_info_idx as mi_idx, aggView6988269965609471331 where mi_idx.movie_id=aggView6988269965609471331.v31);
create or replace view aggJoin4910233042240723581 as (
with aggView8827359390298913113 as (select id as v10 from info_type as it2 where info= 'votes')
select v31, v20 from aggJoin242792709279769810 join aggView8827359390298913113 using(v10));
create or replace view aggView4298997018870245597 as select v31, v20 from aggJoin4910233042240723581 group by v31,v20;
create or replace view aggJoin4698431401333127684 as (
with aggView2095816201984830369 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView2095816201984830369 where mi.info_type_id=aggView2095816201984830369.v8);
create or replace view aggJoin894624935893345306 as (
with aggView4015867157136296333 as (select v31, v15 from aggJoin4698431401333127684 group by v31,v15)
select v31, v15 from aggView4015867157136296333 where v15 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin1050487892538769303 as (
with aggView6613095778575385955 as (select v31, MIN(v20) as v44 from aggView4298997018870245597 group by v31)
select v31, v15, v44 from aggJoin894624935893345306 join aggView6613095778575385955 using(v31));
create or replace view aggJoin4878000774977782438 as (
with aggView907437540814059615 as (select v31, MIN(v44) as v44, MIN(v15) as v43 from aggJoin1050487892538769303 group by v31,v44)
select v32, v44, v43 from aggView7631483939862216047 join aggView907437540814059615 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin4878000774977782438;
