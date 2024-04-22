create or replace view aggView5430030572811358725 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggView3959301072979957057 as select id as v37, title as v38 from title as t;
create or replace view aggJoin7697959132301466866 as (
with aggView4495157698038297968 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView4495157698038297968 where mi_idx.info_type_id=aggView4495157698038297968.v10);
create or replace view aggView6354791046573488284 as select v37, v23 from aggJoin7697959132301466866 group by v37,v23;
create or replace view aggJoin1837645575030377707 as (
with aggView3851654398727855087 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView3851654398727855087 where mi.info_type_id=aggView3851654398727855087.v8);
create or replace view aggJoin8594994055352833908 as (
with aggView3762961845554802857 as (select v37, v18 from aggJoin1837645575030377707 group by v37,v18)
select v37, v18 from aggView3762961845554802857 where v18 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin1009652642013035786 as (
with aggView3736587152985709945 as (select v37, MIN(v18) as v49 from aggJoin8594994055352833908 group by v37)
select v37, v23, v49 from aggView6354791046573488284 join aggView3736587152985709945 using(v37));
create or replace view aggJoin573160625051742132 as (
with aggView1122905454420977563 as (select v37, MIN(v38) as v52 from aggView3959301072979957057 group by v37)
select person_id as v28, movie_id as v37, note as v5, v52 from cast_info as ci, aggView1122905454420977563 where ci.movie_id=aggView1122905454420977563.v37 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin4007830676694946646 as (
with aggView1297552097955851911 as (select v37, MIN(v49) as v49, MIN(v23) as v50 from aggJoin1009652642013035786 group by v37,v49)
select v28, v37, v5, v52 as v52, v49, v50 from aggJoin573160625051742132 join aggView1297552097955851911 using(v37));
create or replace view aggJoin1499191469461900414 as (
with aggView5995824792675856153 as (select id as v12 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v37 from movie_keyword as mk, aggView5995824792675856153 where mk.keyword_id=aggView5995824792675856153.v12);
create or replace view aggJoin4389395940864729516 as (
with aggView170874389326775447 as (select v37 from aggJoin1499191469461900414 group by v37)
select v28, v5, v52 as v52, v49 as v49, v50 as v50 from aggJoin4007830676694946646 join aggView170874389326775447 using(v37));
create or replace view aggJoin1735365755567373683 as (
with aggView4131810087614927734 as (select v28, MIN(v52) as v52, MIN(v49) as v49, MIN(v50) as v50 from aggJoin4389395940864729516 group by v28,v49,v50,v52)
select v29, v52, v49, v50 from aggView5430030572811358725 join aggView4131810087614927734 using(v28));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v29) as v51,MIN(v52) as v52 from aggJoin1735365755567373683;
