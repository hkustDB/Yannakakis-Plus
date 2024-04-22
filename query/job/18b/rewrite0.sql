create or replace view aggView9115311008158567204 as select title as v32, id as v31 from title as t where production_year>=2008 and production_year<=2014;
create or replace view aggJoin9190499331534366016 as (
with aggView4120795465498607155 as (select id as v22 from name as n where gender= 'f')
select movie_id as v31, note as v5 from cast_info as ci, aggView4120795465498607155 where ci.person_id=aggView4120795465498607155.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin1236822013375015848 as (
with aggView8613513732211027665 as (select v31 from aggJoin9190499331534366016 group by v31)
select movie_id as v31, info_type_id as v10, info as v20 from movie_info_idx as mi_idx, aggView8613513732211027665 where mi_idx.movie_id=aggView8613513732211027665.v31);
create or replace view aggJoin4642555209079235215 as (
with aggView1078946766458339500 as (select id as v10 from info_type as it2 where info= 'rating')
select v31, v20 from aggJoin1236822013375015848 join aggView1078946766458339500 using(v10));
create or replace view aggJoin5905026250478163663 as (
with aggView5658514343673916925 as (select v31, v20 from aggJoin4642555209079235215 group by v31,v20)
select v31, v20 from aggView5658514343673916925 where v20>'8.0');
create or replace view aggJoin2360131102040221028 as (
with aggView6937533249974460900 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView6937533249974460900 where mi.info_type_id=aggView6937533249974460900.v8 and info IN ('Horror','Thriller'));
create or replace view aggView1816161793571540758 as select v15, v31 from aggJoin2360131102040221028 group by v15,v31;
create or replace view aggJoin6708660261187719922 as (
with aggView1490437469493186833 as (select v31, MIN(v20) as v44 from aggJoin5905026250478163663 group by v31)
select v32, v31, v44 from aggView9115311008158567204 join aggView1490437469493186833 using(v31));
create or replace view aggJoin8248338979848504321 as (
with aggView5436316473035709578 as (select v31, MIN(v44) as v44, MIN(v32) as v45 from aggJoin6708660261187719922 group by v31,v44)
select v15, v44, v45 from aggView1816161793571540758 join aggView5436316473035709578 using(v31));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin8248338979848504321;
