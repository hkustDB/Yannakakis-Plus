create or replace view aggView1136145477185429971 as select id as v31, title as v32 from title as t;
create or replace view aggJoin2652281187369854936 as (
with aggView1313842481150067932 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView1313842481150067932 where mi_idx.info_type_id=aggView1313842481150067932.v10);
create or replace view aggJoin1908967491573737790 as (
with aggView1264193110673656278 as (select id as v22 from name as n where gender= 'm' and name LIKE '%Tim%')
select movie_id as v31, note as v5 from cast_info as ci, aggView1264193110673656278 where ci.person_id=aggView1264193110673656278.v22 and note IN ('(producer)','(executive producer)'));
create or replace view aggJoin3424143978257539401 as (
with aggView5522909737146241575 as (select v31 from aggJoin1908967491573737790 group by v31)
select v31, v20 from aggJoin2652281187369854936 join aggView5522909737146241575 using(v31));
create or replace view aggView208455159255005724 as select v20, v31 from aggJoin3424143978257539401 group by v20,v31;
create or replace view aggJoin1611446293196540450 as (
with aggView2158074233860291438 as (select id as v8 from info_type as it1 where info= 'budget')
select movie_id as v31, info as v15 from movie_info as mi, aggView2158074233860291438 where mi.info_type_id=aggView2158074233860291438.v8);
create or replace view aggView4724720581543147687 as select v15, v31 from aggJoin1611446293196540450 group by v15,v31;
create or replace view aggJoin1327197055433919867 as (
with aggView1275189622108672589 as (select v31, MIN(v15) as v43 from aggView4724720581543147687 group by v31)
select v20, v31, v43 from aggView208455159255005724 join aggView1275189622108672589 using(v31));
create or replace view aggJoin5308944500052406685 as (
with aggView8987230683795188297 as (select v31, MIN(v32) as v45 from aggView1136145477185429971 group by v31)
select v20, v43 as v43, v45 from aggJoin1327197055433919867 join aggView8987230683795188297 using(v31));
select MIN(v43) as v43,MIN(v20) as v44,MIN(v45) as v45 from aggJoin5308944500052406685;
