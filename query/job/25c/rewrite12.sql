create or replace view aggJoin3970920585578144036 as (
with aggView3101228556080238798 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView3101228556080238798 where ci.person_id=aggView3101228556080238798.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin1467821787471655925 as (
with aggView6417271769660360796 as (select id as v37, title as v52 from title as t)
select movie_id as v37, info_type_id as v10, info as v23, v52 from movie_info_idx as mi_idx, aggView6417271769660360796 where mi_idx.movie_id=aggView6417271769660360796.v37);
create or replace view aggJoin5959801706142131997 as (
with aggView4044878640243919897 as (select id as v10 from info_type as it2 where info= 'votes')
select v37, v23, v52 from aggJoin1467821787471655925 join aggView4044878640243919897 using(v10));
create or replace view aggJoin4133880835365203573 as (
with aggView1033280029953882480 as (select v37, MIN(v52) as v52, MIN(v23) as v50 from aggJoin5959801706142131997 group by v37,v52)
select v37, v5, v51 as v51, v52, v50 from aggJoin3970920585578144036 join aggView1033280029953882480 using(v37));
create or replace view aggJoin6134671770027332726 as (
with aggView3648284136330367514 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView3648284136330367514 where mi.info_type_id=aggView3648284136330367514.v8 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin6155663319739766286 as (
with aggView8192536362035518616 as (select v37, MIN(v18) as v49 from aggJoin6134671770027332726 group by v37)
select movie_id as v37, keyword_id as v12, v49 from movie_keyword as mk, aggView8192536362035518616 where mk.movie_id=aggView8192536362035518616.v37);
create or replace view aggJoin988415798666611095 as (
with aggView217056257356586932 as (select v37, MIN(v51) as v51, MIN(v52) as v52, MIN(v50) as v50 from aggJoin4133880835365203573 group by v37,v50,v52,v51)
select v12, v49 as v49, v51, v52, v50 from aggJoin6155663319739766286 join aggView217056257356586932 using(v37));
create or replace view aggJoin6248395438920450015 as (
with aggView272786389351942968 as (select id as v12 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select v49, v51, v52, v50 from aggJoin988415798666611095 join aggView272786389351942968 using(v12));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin6248395438920450015;
