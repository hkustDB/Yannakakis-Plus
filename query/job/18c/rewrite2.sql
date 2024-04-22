create or replace view aggJoin956823118874193485 as (
with aggView4312789840181659731 as (select id as v22 from name as n where gender= 'm')
select movie_id as v31, note as v5 from cast_info as ci, aggView4312789840181659731 where ci.person_id=aggView4312789840181659731.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin4948665444192886231 as (
with aggView356738752818536263 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView356738752818536263 where mi_idx.info_type_id=aggView356738752818536263.v10);
create or replace view aggView3910151895395965654 as select v31, v20 from aggJoin4948665444192886231 group by v31,v20;
create or replace view aggJoin275217166685527323 as (
with aggView6962313106595204479 as (select v31 from aggJoin956823118874193485 group by v31)
select id as v31, title as v32 from title as t, aggView6962313106595204479 where t.id=aggView6962313106595204479.v31);
create or replace view aggView6619736922597489354 as select v32, v31 from aggJoin275217166685527323 group by v32,v31;
create or replace view aggJoin1329166970989092753 as (
with aggView5002933406877893426 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView5002933406877893426 where mi.info_type_id=aggView5002933406877893426.v8);
create or replace view aggJoin6591535968081175253 as (
with aggView718560028096939979 as (select v31, v15 from aggJoin1329166970989092753 group by v31,v15)
select v31, v15 from aggView718560028096939979 where v15 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin7779616328524830944 as (
with aggView2294892916117785543 as (select v31, MIN(v20) as v44 from aggView3910151895395965654 group by v31)
select v32, v31, v44 from aggView6619736922597489354 join aggView2294892916117785543 using(v31));
create or replace view aggJoin7435579727880123908 as (
with aggView7225001454382174116 as (select v31, MIN(v44) as v44, MIN(v32) as v45 from aggJoin7779616328524830944 group by v31,v44)
select v15, v44, v45 from aggJoin6591535968081175253 join aggView7225001454382174116 using(v31));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin7435579727880123908;
