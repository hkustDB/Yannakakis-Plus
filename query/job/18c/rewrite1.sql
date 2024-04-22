create or replace view aggView4601853834730878518 as select title as v32, id as v31 from title as t;
create or replace view aggJoin5212414018002931366 as (
with aggView4403738716547134514 as (select id as v22 from name as n where gender= 'm')
select movie_id as v31, note as v5 from cast_info as ci, aggView4403738716547134514 where ci.person_id=aggView4403738716547134514.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin6069234593404273447 as (
with aggView8627823253958750334 as (select v31 from aggJoin5212414018002931366 group by v31)
select movie_id as v31, info_type_id as v10, info as v20 from movie_info_idx as mi_idx, aggView8627823253958750334 where mi_idx.movie_id=aggView8627823253958750334.v31);
create or replace view aggJoin1065169260775222546 as (
with aggView2751177530896686901 as (select id as v10 from info_type as it2 where info= 'votes')
select v31, v20 from aggJoin6069234593404273447 join aggView2751177530896686901 using(v10));
create or replace view aggView6455018238385839308 as select v31, v20 from aggJoin1065169260775222546 group by v31,v20;
create or replace view aggJoin5374736182051791202 as (
with aggView4309818501891560461 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView4309818501891560461 where mi.info_type_id=aggView4309818501891560461.v8);
create or replace view aggJoin8220482170267818003 as (
with aggView4666437837667067880 as (select v31, v15 from aggJoin5374736182051791202 group by v31,v15)
select v31, v15 from aggView4666437837667067880 where v15 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin5958883420379773802 as (
with aggView8575019974873475062 as (select v31, MIN(v20) as v44 from aggView6455018238385839308 group by v31)
select v32, v31, v44 from aggView4601853834730878518 join aggView8575019974873475062 using(v31));
create or replace view aggJoin50117744663678591 as (
with aggView6535984793871903841 as (select v31, MIN(v44) as v44, MIN(v32) as v45 from aggJoin5958883420379773802 group by v31,v44)
select v15, v44, v45 from aggJoin8220482170267818003 join aggView6535984793871903841 using(v31));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin50117744663678591;
