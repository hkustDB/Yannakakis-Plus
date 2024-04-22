create or replace view aggJoin7916006256478217395 as (
with aggView9082171079070860077 as (select id as v31, title as v45 from title as t where production_year>=2008 and production_year<=2014)
select person_id as v22, movie_id as v31, note as v5, v45 from cast_info as ci, aggView9082171079070860077 where ci.movie_id=aggView9082171079070860077.v31 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8789149262370065951 as (
with aggView2648799121384663201 as (select id as v22 from name as n where gender= 'f')
select v31, v5, v45 from aggJoin7916006256478217395 join aggView2648799121384663201 using(v22));
create or replace view aggJoin88424318694079998 as (
with aggView8121492448265987193 as (select id as v10 from info_type as it2 where info= 'rating')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView8121492448265987193 where mi_idx.info_type_id=aggView8121492448265987193.v10 and info>'8.0');
create or replace view aggJoin9149504290543144675 as (
with aggView7744258157191248820 as (select v31, MIN(v20) as v44 from aggJoin88424318694079998 group by v31)
select movie_id as v31, info_type_id as v8, info as v15, v44 from movie_info as mi, aggView7744258157191248820 where mi.movie_id=aggView7744258157191248820.v31 and info IN ('Horror','Thriller'));
create or replace view aggJoin1114492816059185174 as (
with aggView5810098253003129981 as (select id as v8 from info_type as it1 where info= 'genres')
select v31, v15, v44 from aggJoin9149504290543144675 join aggView5810098253003129981 using(v8));
create or replace view aggJoin3397136540268493335 as (
with aggView5189136209082240128 as (select v31, MIN(v44) as v44, MIN(v15) as v43 from aggJoin1114492816059185174 group by v31,v44)
select v45 as v45, v44, v43 from aggJoin8789149262370065951 join aggView5189136209082240128 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin3397136540268493335;
