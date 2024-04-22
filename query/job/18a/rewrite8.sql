create or replace view aggJoin268683103460783654 as (
with aggView9117071536026344419 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView9117071536026344419 where mi_idx.info_type_id=aggView9117071536026344419.v10);
create or replace view aggView5770263647132122999 as select v20, v31 from aggJoin268683103460783654 group by v20,v31;
create or replace view aggJoin823620969617432873 as (
with aggView2583444570467658474 as (select id as v22 from name as n where gender= 'm' and name LIKE '%Tim%')
select movie_id as v31, note as v5 from cast_info as ci, aggView2583444570467658474 where ci.person_id=aggView2583444570467658474.v22 and note IN ('(producer)','(executive producer)'));
create or replace view aggJoin2260190395028161520 as (
with aggView8757558400313139600 as (select id as v8 from info_type as it1 where info= 'budget')
select movie_id as v31, info as v15 from movie_info as mi, aggView8757558400313139600 where mi.info_type_id=aggView8757558400313139600.v8);
create or replace view aggView2723280726628894255 as select v15, v31 from aggJoin2260190395028161520 group by v15,v31;
create or replace view aggJoin6070104094221608404 as (
with aggView4628027001941870387 as (select v31 from aggJoin823620969617432873 group by v31)
select id as v31, title as v32 from title as t, aggView4628027001941870387 where t.id=aggView4628027001941870387.v31);
create or replace view aggView5291988578402611949 as select v31, v32 from aggJoin6070104094221608404 group by v31,v32;
create or replace view aggJoin8647036441627454224 as (
with aggView3375734285785641053 as (select v31, MIN(v32) as v45 from aggView5291988578402611949 group by v31)
select v20, v31, v45 from aggView5770263647132122999 join aggView3375734285785641053 using(v31));
create or replace view aggJoin5275372762653027682 as (
with aggView5820230621021385325 as (select v31, MIN(v45) as v45, MIN(v20) as v44 from aggJoin8647036441627454224 group by v31,v45)
select v15, v45, v44 from aggView2723280726628894255 join aggView5820230621021385325 using(v31));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin5275372762653027682;
