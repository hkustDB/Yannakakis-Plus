create or replace view aggJoin3156426319637608854 as (
with aggView5621434708963340470 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView5621434708963340470 where mk.keyword_id=aggView5621434708963340470.v19);
create or replace view aggJoin4443189566044261567 as (
with aggView1212759414272448628 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView1212759414272448628 where mc.company_id=aggView1212759414272448628.v8);
create or replace view aggJoin1294985618549279062 as (
with aggView7683444722221486646 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView7683444722221486646 where mi.info_type_id=aggView7683444722221486646.v15 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin2640425839512265666 as (
with aggView8159126307341914069 as (select v49, MIN(v30) as v61 from aggJoin1294985618549279062 group by v49)
select id as v49, title as v50, v61 from title as t, aggView8159126307341914069 where t.id=aggView8159126307341914069.v49);
create or replace view aggJoin6743633082662433432 as (
with aggView5872334305202527980 as (select v49, MIN(v61) as v61, MIN(v50) as v64 from aggJoin2640425839512265666 group by v49,v61)
select movie_id as v49, info_type_id as v17, info as v35, v61, v64 from movie_info_idx as mi_idx, aggView5872334305202527980 where mi_idx.movie_id=aggView5872334305202527980.v49);
create or replace view aggJoin8659243414431058068 as (
with aggView6633126387100390516 as (select id as v17 from info_type as it2 where info= 'votes')
select v49, v35, v61, v64 from aggJoin6743633082662433432 join aggView6633126387100390516 using(v17));
create or replace view aggJoin2090108197578097202 as (
with aggView6342016712259141816 as (select v49 from aggJoin3156426319637608854 group by v49)
select v49 from aggJoin4443189566044261567 join aggView6342016712259141816 using(v49));
create or replace view aggJoin7748557726378196189 as (
with aggView411492232104228006 as (select v49 from aggJoin2090108197578097202 group by v49)
select v49, v35, v61 as v61, v64 as v64 from aggJoin8659243414431058068 join aggView411492232104228006 using(v49));
create or replace view aggJoin3107023433004116037 as (
with aggView5172639295187458808 as (select v49, MIN(v61) as v61, MIN(v64) as v64, MIN(v35) as v62 from aggJoin7748557726378196189 group by v49,v64,v61)
select person_id as v40, note as v5, v61, v64, v62 from cast_info as ci, aggView5172639295187458808 where ci.movie_id=aggView5172639295187458808.v49 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8930371444355783143 as (
with aggView9176184455589465452 as (select v40, MIN(v61) as v61, MIN(v64) as v64, MIN(v62) as v62 from aggJoin3107023433004116037 group by v40,v64,v61,v62)
select name as v41, v61, v64, v62 from name as n, aggView9176184455589465452 where n.id=aggView9176184455589465452.v40);
select MIN(v61) as v61,MIN(v62) as v62,MIN(v41) as v63,MIN(v64) as v64 from aggJoin8930371444355783143;
