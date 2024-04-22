create or replace view aggJoin3630188290850965470 as (
with aggView4027401992813517333 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView4027401992813517333 where mi_idx.info_type_id=aggView4027401992813517333.v10);
create or replace view aggJoin1398370150666931218 as (
with aggView8214687858307504101 as (select id as v22 from name as n where gender= 'm' and name LIKE '%Tim%')
select movie_id as v31, note as v5 from cast_info as ci, aggView8214687858307504101 where ci.person_id=aggView8214687858307504101.v22 and note IN ('(producer)','(executive producer)'));
create or replace view aggJoin5572906715583840259 as (
with aggView5940736622486952980 as (select id as v8 from info_type as it1 where info= 'budget')
select movie_id as v31, info as v15 from movie_info as mi, aggView5940736622486952980 where mi.info_type_id=aggView5940736622486952980.v8);
create or replace view aggJoin5224624896955644044 as (
with aggView8146022027359120456 as (select v31 from aggJoin1398370150666931218 group by v31)
select id as v31, title as v32 from title as t, aggView8146022027359120456 where t.id=aggView8146022027359120456.v31);
create or replace view aggJoin4876090256121660830 as (
with aggView8710946922334636792 as (select v31, MIN(v32) as v45 from aggJoin5224624896955644044 group by v31)
select v31, v20, v45 from aggJoin3630188290850965470 join aggView8710946922334636792 using(v31));
create or replace view aggJoin5346308397591219853 as (
with aggView9107925660936160716 as (select v31, MIN(v45) as v45, MIN(v20) as v44 from aggJoin4876090256121660830 group by v31,v45)
select v15, v45, v44 from aggJoin5572906715583840259 join aggView9107925660936160716 using(v31));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin5346308397591219853;
