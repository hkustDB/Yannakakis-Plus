create or replace view aggJoin2758570417346674754 as (
with aggView4758124318309737185 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView4758124318309737185 where ci.person_id=aggView4758124318309737185.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8524696503421028880 as (
with aggView1153542102727836524 as (select id as v37, title as v52 from title as t)
select movie_id as v37, keyword_id as v12, v52 from movie_keyword as mk, aggView1153542102727836524 where mk.movie_id=aggView1153542102727836524.v37);
create or replace view aggJoin8339377538600308236 as (
with aggView9071584482265969238 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView9071584482265969238 where mi_idx.info_type_id=aggView9071584482265969238.v10);
create or replace view aggJoin6485821098682371488 as (
with aggView9141666024066471515 as (select v37, MIN(v23) as v50 from aggJoin8339377538600308236 group by v37)
select v37, v5, v51 as v51, v50 from aggJoin2758570417346674754 join aggView9141666024066471515 using(v37));
create or replace view aggJoin5509675345991267263 as (
with aggView1534432200596184538 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView1534432200596184538 where mi.info_type_id=aggView1534432200596184538.v8 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin5867297976364176987 as (
with aggView1216224348802238563 as (select v37, MIN(v18) as v49 from aggJoin5509675345991267263 group by v37)
select v37, v5, v51 as v51, v50 as v50, v49 from aggJoin6485821098682371488 join aggView1216224348802238563 using(v37));
create or replace view aggJoin8573905205537559349 as (
with aggView2626915807137532886 as (select v37, MIN(v51) as v51, MIN(v50) as v50, MIN(v49) as v49 from aggJoin5867297976364176987 group by v37,v49,v50,v51)
select v12, v52 as v52, v51, v50, v49 from aggJoin8524696503421028880 join aggView2626915807137532886 using(v37));
create or replace view aggJoin82107091038538318 as (
with aggView9049908361241331797 as (select id as v12 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select v52, v51, v50, v49 from aggJoin8573905205537559349 join aggView9049908361241331797 using(v12));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin82107091038538318;
