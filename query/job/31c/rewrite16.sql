create or replace view aggJoin5099110471302963109 as (
with aggView7490724274862948592 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView7490724274862948592 where mk.keyword_id=aggView7490724274862948592.v19);
create or replace view aggJoin5002815859080763059 as (
with aggView8601106204009907783 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView8601106204009907783 where mi_idx.info_type_id=aggView8601106204009907783.v17);
create or replace view aggJoin2590938038700448100 as (
with aggView3883281961794070497 as (select v49, MIN(v35) as v62 from aggJoin5002815859080763059 group by v49)
select movie_id as v49, company_id as v8, v62 from movie_companies as mc, aggView3883281961794070497 where mc.movie_id=aggView3883281961794070497.v49);
create or replace view aggJoin6494391034573347684 as (
with aggView5896497571075079066 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select v49, v62 from aggJoin2590938038700448100 join aggView5896497571075079066 using(v8));
create or replace view aggJoin4321976331947284300 as (
with aggView2035745635099061123 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView2035745635099061123 where mi.info_type_id=aggView2035745635099061123.v15 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin8375883569126380519 as (
with aggView708719965342468471 as (select v49, MIN(v30) as v61 from aggJoin4321976331947284300 group by v49)
select person_id as v40, movie_id as v49, note as v5, v61 from cast_info as ci, aggView708719965342468471 where ci.movie_id=aggView708719965342468471.v49 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin318952634458506623 as (
with aggView5133782139332168610 as (select v49 from aggJoin5099110471302963109 group by v49)
select v49, v62 as v62 from aggJoin6494391034573347684 join aggView5133782139332168610 using(v49));
create or replace view aggJoin9064771079176099944 as (
with aggView5593961604520742060 as (select v49, MIN(v62) as v62 from aggJoin318952634458506623 group by v49,v62)
select id as v49, title as v50, v62 from title as t, aggView5593961604520742060 where t.id=aggView5593961604520742060.v49);
create or replace view aggJoin2655367242322249184 as (
with aggView5032252857382723342 as (select v49, MIN(v62) as v62, MIN(v50) as v64 from aggJoin9064771079176099944 group by v49,v62)
select v40, v5, v61 as v61, v62, v64 from aggJoin8375883569126380519 join aggView5032252857382723342 using(v49));
create or replace view aggJoin2215692285648294918 as (
with aggView9141200954522398984 as (select v40, MIN(v61) as v61, MIN(v62) as v62, MIN(v64) as v64 from aggJoin2655367242322249184 group by v40,v64,v61,v62)
select name as v41, v61, v62, v64 from name as n, aggView9141200954522398984 where n.id=aggView9141200954522398984.v40);
select MIN(v61) as v61,MIN(v62) as v62,MIN(v41) as v63,MIN(v64) as v64 from aggJoin2215692285648294918;
