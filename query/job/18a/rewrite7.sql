create or replace view aggView5502820612601231595 as select id as v31, title as v32 from title as t;
create or replace view aggJoin3280641476625257369 as (
with aggView5411536570561286865 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView5411536570561286865 where mi_idx.info_type_id=aggView5411536570561286865.v10);
create or replace view aggView3983524353087603619 as select v20, v31 from aggJoin3280641476625257369 group by v20,v31;
create or replace view aggJoin5500295181453690295 as (
with aggView6768879179058432058 as (select id as v22 from name as n where gender= 'm' and name LIKE '%Tim%')
select movie_id as v31, note as v5 from cast_info as ci, aggView6768879179058432058 where ci.person_id=aggView6768879179058432058.v22 and note IN ('(producer)','(executive producer)'));
create or replace view aggJoin1446965454103925221 as (
with aggView1555779117717639592 as (select v31 from aggJoin5500295181453690295 group by v31)
select movie_id as v31, info_type_id as v8, info as v15 from movie_info as mi, aggView1555779117717639592 where mi.movie_id=aggView1555779117717639592.v31);
create or replace view aggJoin2662125587123257975 as (
with aggView5694737527243688374 as (select id as v8 from info_type as it1 where info= 'budget')
select v31, v15 from aggJoin1446965454103925221 join aggView5694737527243688374 using(v8));
create or replace view aggView4322096532563773417 as select v15, v31 from aggJoin2662125587123257975 group by v15,v31;
create or replace view aggJoin1351819045113778894 as (
with aggView2726297050033125087 as (select v31, MIN(v32) as v45 from aggView5502820612601231595 group by v31)
select v15, v31, v45 from aggView4322096532563773417 join aggView2726297050033125087 using(v31));
create or replace view aggJoin726014420589745988 as (
with aggView513985187711107292 as (select v31, MIN(v45) as v45, MIN(v15) as v43 from aggJoin1351819045113778894 group by v31,v45)
select v20, v45, v43 from aggView3983524353087603619 join aggView513985187711107292 using(v31));
select MIN(v43) as v43,MIN(v20) as v44,MIN(v45) as v45 from aggJoin726014420589745988;
