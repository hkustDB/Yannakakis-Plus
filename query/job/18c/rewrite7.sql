create or replace view aggView6666032050508059256 as select title as v32, id as v31 from title as t;
create or replace view aggJoin439313494987071052 as (
with aggView8438746057685174401 as (select id as v22 from name as n where gender= 'm')
select movie_id as v31, note as v5 from cast_info as ci, aggView8438746057685174401 where ci.person_id=aggView8438746057685174401.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin248176015007078988 as (
with aggView5544961381703085201 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView5544961381703085201 where mi_idx.info_type_id=aggView5544961381703085201.v10);
create or replace view aggView767816416776027739 as select v31, v20 from aggJoin248176015007078988 group by v31,v20;
create or replace view aggJoin7355078966462419453 as (
with aggView8745271200442763560 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView8745271200442763560 where mi.info_type_id=aggView8745271200442763560.v8);
create or replace view aggJoin1659311295913598338 as (
with aggView3500799720402151232 as (select v31 from aggJoin439313494987071052 group by v31)
select v31, v15 from aggJoin7355078966462419453 join aggView3500799720402151232 using(v31));
create or replace view aggJoin2592818538104649537 as (
with aggView3616196202022817814 as (select v31, v15 from aggJoin1659311295913598338 group by v31,v15)
select v31, v15 from aggView3616196202022817814 where v15 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin214704070370488793 as (
with aggView1937341764353506570 as (select v31, MIN(v32) as v45 from aggView6666032050508059256 group by v31)
select v31, v20, v45 from aggView767816416776027739 join aggView1937341764353506570 using(v31));
create or replace view aggJoin1815475866784002179 as (
with aggView3871533115409772081 as (select v31, MIN(v45) as v45, MIN(v20) as v44 from aggJoin214704070370488793 group by v31,v45)
select v15, v45, v44 from aggJoin2592818538104649537 join aggView3871533115409772081 using(v31));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin1815475866784002179;
