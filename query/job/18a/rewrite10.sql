create or replace view aggJoin678807999611546200 as (
with aggView7011009812771167510 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView7011009812771167510 where mi_idx.info_type_id=aggView7011009812771167510.v10);
create or replace view aggJoin5674172804037359981 as (
with aggView3120402899036257586 as (select v31, MIN(v20) as v44 from aggJoin678807999611546200 group by v31)
select id as v31, title as v32, v44 from title as t, aggView3120402899036257586 where t.id=aggView3120402899036257586.v31);
create or replace view aggJoin447402091253838645 as (
with aggView8815691133933358769 as (select id as v22 from name as n where gender= 'm' and name LIKE '%Tim%')
select movie_id as v31, note as v5 from cast_info as ci, aggView8815691133933358769 where ci.person_id=aggView8815691133933358769.v22 and note IN ('(producer)','(executive producer)'));
create or replace view aggJoin4940241661241330231 as (
with aggView6448777660251266213 as (select id as v8 from info_type as it1 where info= 'budget')
select movie_id as v31, info as v15 from movie_info as mi, aggView6448777660251266213 where mi.info_type_id=aggView6448777660251266213.v8);
create or replace view aggJoin2800811820609550737 as (
with aggView814667769967418239 as (select v31 from aggJoin447402091253838645 group by v31)
select v31, v32, v44 as v44 from aggJoin5674172804037359981 join aggView814667769967418239 using(v31));
create or replace view aggJoin7742401947805526802 as (
with aggView1829950884271527885 as (select v31, MIN(v44) as v44, MIN(v32) as v45 from aggJoin2800811820609550737 group by v31,v44)
select v15, v44, v45 from aggJoin4940241661241330231 join aggView1829950884271527885 using(v31));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin7742401947805526802;
