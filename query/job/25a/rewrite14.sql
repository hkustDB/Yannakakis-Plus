create or replace view aggJoin2915001144217089996 as (
with aggView8227240602710349024 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView8227240602710349024 where ci.person_id=aggView8227240602710349024.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin4280832490487409454 as (
with aggView6187514282119185272 as (select id as v37, title as v52 from title as t)
select movie_id as v37, info_type_id as v10, info as v23, v52 from movie_info_idx as mi_idx, aggView6187514282119185272 where mi_idx.movie_id=aggView6187514282119185272.v37);
create or replace view aggJoin3028783808937502499 as (
with aggView4811805501495730480 as (select id as v10 from info_type as it2 where info= 'votes')
select v37, v23, v52 from aggJoin4280832490487409454 join aggView4811805501495730480 using(v10));
create or replace view aggJoin6929596847210894863 as (
with aggView6358028054387603818 as (select v37, MIN(v52) as v52, MIN(v23) as v50 from aggJoin3028783808937502499 group by v37,v52)
select movie_id as v37, keyword_id as v12, v52, v50 from movie_keyword as mk, aggView6358028054387603818 where mk.movie_id=aggView6358028054387603818.v37);
create or replace view aggJoin333718478643723954 as (
with aggView8032809107319829019 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select v37, v52, v50 from aggJoin6929596847210894863 join aggView8032809107319829019 using(v12));
create or replace view aggJoin1071287962853398378 as (
with aggView8964209012269602549 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView8964209012269602549 where mi.info_type_id=aggView8964209012269602549.v8 and info= 'Horror');
create or replace view aggJoin5538269666225449048 as (
with aggView3940276388299516794 as (select v37, MIN(v18) as v49 from aggJoin1071287962853398378 group by v37)
select v37, v5, v51 as v51, v49 from aggJoin2915001144217089996 join aggView3940276388299516794 using(v37));
create or replace view aggJoin5614810442191249364 as (
with aggView7549816597964864688 as (select v37, MIN(v51) as v51, MIN(v49) as v49 from aggJoin5538269666225449048 group by v37,v51,v49)
select v52 as v52, v50 as v50, v51, v49 from aggJoin333718478643723954 join aggView7549816597964864688 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin5614810442191249364;
