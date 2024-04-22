create or replace view aggJoin6201176264912666310 as (
with aggView450781254828146595 as (select id as v22 from name as n where gender= 'm')
select movie_id as v31, note as v5 from cast_info as ci, aggView450781254828146595 where ci.person_id=aggView450781254828146595.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3674036446978923949 as (
with aggView3914986153786672941 as (select v31 from aggJoin6201176264912666310 group by v31)
select movie_id as v31, info_type_id as v10, info as v20 from movie_info_idx as mi_idx, aggView3914986153786672941 where mi_idx.movie_id=aggView3914986153786672941.v31);
create or replace view aggJoin1683187900033509116 as (
with aggView1903333889633574946 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView1903333889633574946 where mi.info_type_id=aggView1903333889633574946.v8 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin8309856545988662551 as (
with aggView8071001329219014418 as (select v31, MIN(v15) as v43 from aggJoin1683187900033509116 group by v31)
select id as v31, title as v32, v43 from title as t, aggView8071001329219014418 where t.id=aggView8071001329219014418.v31);
create or replace view aggJoin631765283283879372 as (
with aggView8745104302601677715 as (select id as v10 from info_type as it2 where info= 'votes')
select v31, v20 from aggJoin3674036446978923949 join aggView8745104302601677715 using(v10));
create or replace view aggJoin2744191484008364203 as (
with aggView3653483914673126513 as (select v31, MIN(v20) as v44 from aggJoin631765283283879372 group by v31)
select v32, v43 as v43, v44 from aggJoin8309856545988662551 join aggView3653483914673126513 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin2744191484008364203;
