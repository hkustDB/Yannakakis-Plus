create or replace view aggJoin7771855887532045536 as (
with aggView2584793643618283669 as (select id as v22 from name as n where gender= 'm')
select movie_id as v31, note as v5 from cast_info as ci, aggView2584793643618283669 where ci.person_id=aggView2584793643618283669.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3580337149269473923 as (
with aggView982472533973606037 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView982472533973606037 where mi.info_type_id=aggView982472533973606037.v8 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin7529675225866019912 as (
with aggView1257088386823611955 as (select v31, MIN(v15) as v43 from aggJoin3580337149269473923 group by v31)
select v31, v5, v43 from aggJoin7771855887532045536 join aggView1257088386823611955 using(v31));
create or replace view aggJoin1627906110584236474 as (
with aggView3147991427128228377 as (select v31, MIN(v43) as v43 from aggJoin7529675225866019912 group by v31,v43)
select id as v31, title as v32, v43 from title as t, aggView3147991427128228377 where t.id=aggView3147991427128228377.v31);
create or replace view aggJoin6240037496900703204 as (
with aggView3349180521263770391 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView3349180521263770391 where mi_idx.info_type_id=aggView3349180521263770391.v10);
create or replace view aggJoin4681920489237857795 as (
with aggView1010783485024123761 as (select v31, MIN(v20) as v44 from aggJoin6240037496900703204 group by v31)
select v32, v43 as v43, v44 from aggJoin1627906110584236474 join aggView1010783485024123761 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin4681920489237857795;
