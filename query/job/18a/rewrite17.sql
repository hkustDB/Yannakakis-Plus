create or replace view aggJoin4872025271640860581 as (
with aggView3583505137542146423 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView3583505137542146423 where mi_idx.info_type_id=aggView3583505137542146423.v10);
create or replace view aggJoin7826101042030604073 as (
with aggView1259255234599507322 as (select v31, MIN(v20) as v44 from aggJoin4872025271640860581 group by v31)
select id as v31, title as v32, v44 from title as t, aggView1259255234599507322 where t.id=aggView1259255234599507322.v31);
create or replace view aggJoin4854947909860820458 as (
with aggView4767217413674649506 as (select v31, MIN(v44) as v44, MIN(v32) as v45 from aggJoin7826101042030604073 group by v31,v44)
select movie_id as v31, info_type_id as v8, info as v15, v44, v45 from movie_info as mi, aggView4767217413674649506 where mi.movie_id=aggView4767217413674649506.v31);
create or replace view aggJoin4302280908375751808 as (
with aggView7842918480752315390 as (select id as v22 from name as n where gender= 'm' and name LIKE '%Tim%')
select movie_id as v31, note as v5 from cast_info as ci, aggView7842918480752315390 where ci.person_id=aggView7842918480752315390.v22 and note IN ('(producer)','(executive producer)'));
create or replace view aggJoin3683075753866642625 as (
with aggView7980200586428285656 as (select v31 from aggJoin4302280908375751808 group by v31)
select v8, v15, v44 as v44, v45 as v45 from aggJoin4854947909860820458 join aggView7980200586428285656 using(v31));
create or replace view aggJoin5749779331096250097 as (
with aggView4582825404215996288 as (select id as v8 from info_type as it1 where info= 'budget')
select v15, v44, v45 from aggJoin3683075753866642625 join aggView4582825404215996288 using(v8));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin5749779331096250097;
