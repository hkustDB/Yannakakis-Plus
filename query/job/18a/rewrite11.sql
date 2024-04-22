create or replace view aggJoin5249792698624872837 as (
with aggView3915779481034165613 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView3915779481034165613 where mi_idx.info_type_id=aggView3915779481034165613.v10);
create or replace view aggJoin12021589666137094 as (
with aggView4129037344986084611 as (select id as v22 from name as n where gender= 'm' and name LIKE '%Tim%')
select movie_id as v31, note as v5 from cast_info as ci, aggView4129037344986084611 where ci.person_id=aggView4129037344986084611.v22 and note IN ('(producer)','(executive producer)'));
create or replace view aggJoin3309515020294861705 as (
with aggView4053147666623353305 as (select v31 from aggJoin12021589666137094 group by v31)
select v31, v20 from aggJoin5249792698624872837 join aggView4053147666623353305 using(v31));
create or replace view aggJoin8849483279441762941 as (
with aggView6377038919736071950 as (select v31, MIN(v20) as v44 from aggJoin3309515020294861705 group by v31)
select id as v31, title as v32, v44 from title as t, aggView6377038919736071950 where t.id=aggView6377038919736071950.v31);
create or replace view aggJoin2082828781266412595 as (
with aggView1858674038986790720 as (select v31, MIN(v44) as v44, MIN(v32) as v45 from aggJoin8849483279441762941 group by v31,v44)
select info_type_id as v8, info as v15, v44, v45 from movie_info as mi, aggView1858674038986790720 where mi.movie_id=aggView1858674038986790720.v31);
create or replace view aggJoin2024488810780982153 as (
with aggView3621417604107474358 as (select id as v8 from info_type as it1 where info= 'budget')
select v15, v44, v45 from aggJoin2082828781266412595 join aggView3621417604107474358 using(v8));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin2024488810780982153;
