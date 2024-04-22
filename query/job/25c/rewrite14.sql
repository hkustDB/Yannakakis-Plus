create or replace view aggJoin639638755523289067 as (
with aggView575368860943562843 as (select id as v37, title as v52 from title as t)
select person_id as v28, movie_id as v37, note as v5, v52 from cast_info as ci, aggView575368860943562843 where ci.movie_id=aggView575368860943562843.v37 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin41708697746714510 as (
with aggView8524155347770238342 as (select id as v28, name as v51 from name as n where gender= 'm')
select v37, v5, v52, v51 from aggJoin639638755523289067 join aggView8524155347770238342 using(v28));
create or replace view aggJoin4212989378333141681 as (
with aggView8723718393331939007 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView8723718393331939007 where mi_idx.info_type_id=aggView8723718393331939007.v10);
create or replace view aggJoin6619444197180439935 as (
with aggView6183426607290510697 as (select v37, MIN(v23) as v50 from aggJoin4212989378333141681 group by v37)
select movie_id as v37, keyword_id as v12, v50 from movie_keyword as mk, aggView6183426607290510697 where mk.movie_id=aggView6183426607290510697.v37);
create or replace view aggJoin1631256346723565270 as (
with aggView6565046774374656713 as (select v37, MIN(v52) as v52, MIN(v51) as v51 from aggJoin41708697746714510 group by v37,v52,v51)
select movie_id as v37, info_type_id as v8, info as v18, v52, v51 from movie_info as mi, aggView6565046774374656713 where mi.movie_id=aggView6565046774374656713.v37 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin2409316260821568906 as (
with aggView8014087790197153605 as (select id as v8 from info_type as it1 where info= 'genres')
select v37, v18, v52, v51 from aggJoin1631256346723565270 join aggView8014087790197153605 using(v8));
create or replace view aggJoin4141594956338209257 as (
with aggView6219354347495461466 as (select v37, MIN(v52) as v52, MIN(v51) as v51, MIN(v18) as v49 from aggJoin2409316260821568906 group by v37,v52,v51)
select v12, v50 as v50, v52, v51, v49 from aggJoin6619444197180439935 join aggView6219354347495461466 using(v37));
create or replace view aggJoin8678787090738917778 as (
with aggView4557751186486073964 as (select id as v12 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select v50, v52, v51, v49 from aggJoin4141594956338209257 join aggView4557751186486073964 using(v12));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin8678787090738917778;
