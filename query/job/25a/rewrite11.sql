create or replace view aggJoin886788104792333453 as (
with aggView5295861016607801006 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView5295861016607801006 where ci.person_id=aggView5295861016607801006.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5656675766822709257 as (
with aggView6245712979090503327 as (select id as v37, title as v52 from title as t)
select movie_id as v37, info_type_id as v10, info as v23, v52 from movie_info_idx as mi_idx, aggView6245712979090503327 where mi_idx.movie_id=aggView6245712979090503327.v37);
create or replace view aggJoin8992590043505270386 as (
with aggView5163862878207861599 as (select id as v10 from info_type as it2 where info= 'votes')
select v37, v23, v52 from aggJoin5656675766822709257 join aggView5163862878207861599 using(v10));
create or replace view aggJoin4747310315795982369 as (
with aggView825502136843153913 as (select v37, MIN(v52) as v52, MIN(v23) as v50 from aggJoin8992590043505270386 group by v37,v52)
select v37, v5, v51 as v51, v52, v50 from aggJoin886788104792333453 join aggView825502136843153913 using(v37));
create or replace view aggJoin4600499963377608486 as (
with aggView3317801461315349383 as (select v37, MIN(v51) as v51, MIN(v52) as v52, MIN(v50) as v50 from aggJoin4747310315795982369 group by v37,v51,v52,v50)
select movie_id as v37, keyword_id as v12, v51, v52, v50 from movie_keyword as mk, aggView3317801461315349383 where mk.movie_id=aggView3317801461315349383.v37);
create or replace view aggJoin8731744419877877130 as (
with aggView6101045828894817526 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select v37, v51, v52, v50 from aggJoin4600499963377608486 join aggView6101045828894817526 using(v12));
create or replace view aggJoin9033912300493445184 as (
with aggView6706183732680867779 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView6706183732680867779 where mi.info_type_id=aggView6706183732680867779.v8 and info= 'Horror');
create or replace view aggJoin1637755032567733743 as (
with aggView7405776133543712968 as (select v37, MIN(v18) as v49 from aggJoin9033912300493445184 group by v37)
select v51 as v51, v52 as v52, v50 as v50, v49 from aggJoin8731744419877877130 join aggView7405776133543712968 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin1637755032567733743;
