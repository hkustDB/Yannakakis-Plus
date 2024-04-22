create or replace view aggView1072554254157216514 as select id as v31, title as v32 from title as t;
create or replace view aggJoin605195094784112515 as (
with aggView2536406989883231935 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView2536406989883231935 where mi_idx.info_type_id=aggView2536406989883231935.v10);
create or replace view aggJoin9027041814785129203 as (
with aggView7928381839336174361 as (select id as v22 from name as n where gender= 'm' and name LIKE '%Tim%')
select movie_id as v31, note as v5 from cast_info as ci, aggView7928381839336174361 where ci.person_id=aggView7928381839336174361.v22 and note IN ('(producer)','(executive producer)'));
create or replace view aggJoin6384534624361537583 as (
with aggView1863930072905042890 as (select v31 from aggJoin9027041814785129203 group by v31)
select v31, v20 from aggJoin605195094784112515 join aggView1863930072905042890 using(v31));
create or replace view aggView2624130636281004942 as select v20, v31 from aggJoin6384534624361537583 group by v20,v31;
create or replace view aggJoin129462731431202799 as (
with aggView7426074420404298831 as (select id as v8 from info_type as it1 where info= 'budget')
select movie_id as v31, info as v15 from movie_info as mi, aggView7426074420404298831 where mi.info_type_id=aggView7426074420404298831.v8);
create or replace view aggView8909364107285052776 as select v15, v31 from aggJoin129462731431202799 group by v15,v31;
create or replace view aggJoin8001220585005869752 as (
with aggView265941637413137708 as (select v31, MIN(v20) as v44 from aggView2624130636281004942 group by v31)
select v15, v31, v44 from aggView8909364107285052776 join aggView265941637413137708 using(v31));
create or replace view aggJoin6884746630610040856 as (
with aggView2917085640380281038 as (select v31, MIN(v44) as v44, MIN(v15) as v43 from aggJoin8001220585005869752 group by v31,v44)
select v32, v44, v43 from aggView1072554254157216514 join aggView2917085640380281038 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin6884746630610040856;
