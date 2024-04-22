create or replace view aggJoin8916162032008061063 as (
with aggView7561986912197529533 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView7561986912197529533 where ci.person_id=aggView7561986912197529533.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin686249032136514245 as (
with aggView5757591170795169745 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView5757591170795169745 where mi_idx.info_type_id=aggView5757591170795169745.v10);
create or replace view aggJoin6175899917178563352 as (
with aggView8242146454888016313 as (select v37, MIN(v23) as v50 from aggJoin686249032136514245 group by v37)
select id as v37, title as v38, v50 from title as t, aggView8242146454888016313 where t.id=aggView8242146454888016313.v37);
create or replace view aggJoin3192143620182553014 as (
with aggView4423032238587581246 as (select v37, MIN(v50) as v50, MIN(v38) as v52 from aggJoin6175899917178563352 group by v37,v50)
select v37, v5, v51 as v51, v50, v52 from aggJoin8916162032008061063 join aggView4423032238587581246 using(v37));
create or replace view aggJoin8340810419219491501 as (
with aggView9002411016912019024 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView9002411016912019024 where mi.info_type_id=aggView9002411016912019024.v8 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin4451715317562925750 as (
with aggView4788498511524741073 as (select v37, MIN(v18) as v49 from aggJoin8340810419219491501 group by v37)
select movie_id as v37, keyword_id as v12, v49 from movie_keyword as mk, aggView4788498511524741073 where mk.movie_id=aggView4788498511524741073.v37);
create or replace view aggJoin3769890434699997901 as (
with aggView6626791489906518336 as (select v37, MIN(v51) as v51, MIN(v50) as v50, MIN(v52) as v52 from aggJoin3192143620182553014 group by v37,v50,v52,v51)
select v12, v49 as v49, v51, v50, v52 from aggJoin4451715317562925750 join aggView6626791489906518336 using(v37));
create or replace view aggJoin5968561816427328934 as (
with aggView846261154312007804 as (select id as v12 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select v49, v51, v50, v52 from aggJoin3769890434699997901 join aggView846261154312007804 using(v12));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin5968561816427328934;
