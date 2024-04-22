create or replace view aggJoin2083145904419658745 as (
with aggView926994677877413388 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView926994677877413388 where ci.person_id=aggView926994677877413388.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5792028219097757985 as (
with aggView1181654945873465687 as (select id as v37, title as v52 from title as t where production_year>2010 and title LIKE 'Vampire%')
select movie_id as v37, keyword_id as v12, v52 from movie_keyword as mk, aggView1181654945873465687 where mk.movie_id=aggView1181654945873465687.v37);
create or replace view aggJoin4597040375194777925 as (
with aggView6259434584829676842 as (select v37, MIN(v51) as v51 from aggJoin2083145904419658745 group by v37,v51)
select movie_id as v37, info_type_id as v10, info as v23, v51 from movie_info_idx as mi_idx, aggView6259434584829676842 where mi_idx.movie_id=aggView6259434584829676842.v37);
create or replace view aggJoin209714126766484225 as (
with aggView1314760212884603796 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView1314760212884603796 where mi.info_type_id=aggView1314760212884603796.v8 and info= 'Horror');
create or replace view aggJoin1050307254652970140 as (
with aggView984965835006451927 as (select v37, MIN(v18) as v49 from aggJoin209714126766484225 group by v37)
select v37, v12, v52 as v52, v49 from aggJoin5792028219097757985 join aggView984965835006451927 using(v37));
create or replace view aggJoin8271491039576156389 as (
with aggView8429285406535437155 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select v37, v52, v49 from aggJoin1050307254652970140 join aggView8429285406535437155 using(v12));
create or replace view aggJoin6190284293744242097 as (
with aggView3987281757057466513 as (select id as v10 from info_type as it2 where info= 'votes')
select v37, v23, v51 from aggJoin4597040375194777925 join aggView3987281757057466513 using(v10));
create or replace view aggJoin6065319518715571125 as (
with aggView7761561806083473456 as (select v37, MIN(v51) as v51, MIN(v23) as v50 from aggJoin6190284293744242097 group by v37,v51)
select v52 as v52, v49 as v49, v51, v50 from aggJoin8271491039576156389 join aggView7761561806083473456 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin6065319518715571125;
