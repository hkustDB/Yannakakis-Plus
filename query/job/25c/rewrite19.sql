create or replace view aggJoin8263200942606669925 as (
with aggView4804989871533147006 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView4804989871533147006 where ci.person_id=aggView4804989871533147006.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin4903577383959875469 as (
with aggView3433409818714397707 as (select id as v37, title as v52 from title as t)
select movie_id as v37, keyword_id as v12, v52 from movie_keyword as mk, aggView3433409818714397707 where mk.movie_id=aggView3433409818714397707.v37);
create or replace view aggJoin4194615081469751319 as (
with aggView5475617671744724198 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView5475617671744724198 where mi_idx.info_type_id=aggView5475617671744724198.v10);
create or replace view aggJoin6726663554356585217 as (
with aggView4987654669333613378 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView4987654669333613378 where mi.info_type_id=aggView4987654669333613378.v8 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin7519106665914727050 as (
with aggView8973015596347767579 as (select v37, MIN(v18) as v49 from aggJoin6726663554356585217 group by v37)
select v37, v23, v49 from aggJoin4194615081469751319 join aggView8973015596347767579 using(v37));
create or replace view aggJoin6613324328317926121 as (
with aggView2519342128108447930 as (select v37, MIN(v49) as v49, MIN(v23) as v50 from aggJoin7519106665914727050 group by v37,v49)
select v37, v12, v52 as v52, v49, v50 from aggJoin4903577383959875469 join aggView2519342128108447930 using(v37));
create or replace view aggJoin5440514878259835646 as (
with aggView7319104369041160524 as (select v37, MIN(v51) as v51 from aggJoin8263200942606669925 group by v37,v51)
select v12, v52 as v52, v49 as v49, v50 as v50, v51 from aggJoin6613324328317926121 join aggView7319104369041160524 using(v37));
create or replace view aggJoin7550022900880286748 as (
with aggView6543569741887110210 as (select id as v12 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select v52, v49, v50, v51 from aggJoin5440514878259835646 join aggView6543569741887110210 using(v12));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin7550022900880286748;
