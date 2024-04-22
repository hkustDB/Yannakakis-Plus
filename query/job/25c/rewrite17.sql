create or replace view aggJoin7199871101948478388 as (
with aggView3952071579841910173 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView3952071579841910173 where ci.person_id=aggView3952071579841910173.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin665296384189975712 as (
with aggView551201072184865584 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView551201072184865584 where mi_idx.info_type_id=aggView551201072184865584.v10);
create or replace view aggJoin5487971779134821666 as (
with aggView8086327631720871633 as (select v37, MIN(v51) as v51 from aggJoin7199871101948478388 group by v37,v51)
select v37, v23, v51 from aggJoin665296384189975712 join aggView8086327631720871633 using(v37));
create or replace view aggJoin8448484554096398373 as (
with aggView7470909550519343562 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView7470909550519343562 where mi.info_type_id=aggView7470909550519343562.v8 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin8566079223619720082 as (
with aggView4767458446210435556 as (select v37, MIN(v18) as v49 from aggJoin8448484554096398373 group by v37)
select v37, v23, v51 as v51, v49 from aggJoin5487971779134821666 join aggView4767458446210435556 using(v37));
create or replace view aggJoin6102718592065627409 as (
with aggView1280575180662124230 as (select v37, MIN(v51) as v51, MIN(v49) as v49, MIN(v23) as v50 from aggJoin8566079223619720082 group by v37,v49,v51)
select id as v37, title as v38, v51, v49, v50 from title as t, aggView1280575180662124230 where t.id=aggView1280575180662124230.v37);
create or replace view aggJoin8513875055353414940 as (
with aggView9106153427044494221 as (select v37, MIN(v51) as v51, MIN(v49) as v49, MIN(v50) as v50, MIN(v38) as v52 from aggJoin6102718592065627409 group by v37,v49,v50,v51)
select keyword_id as v12, v51, v49, v50, v52 from movie_keyword as mk, aggView9106153427044494221 where mk.movie_id=aggView9106153427044494221.v37);
create or replace view aggJoin5175136261813014433 as (
with aggView8513270312021204527 as (select id as v12 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select v51, v49, v50, v52 from aggJoin8513875055353414940 join aggView8513270312021204527 using(v12));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin5175136261813014433;
