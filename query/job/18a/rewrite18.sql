create or replace view aggJoin5173380698656692940 as (
with aggView8987161907298427303 as (select id as v31, title as v45 from title as t)
select person_id as v22, movie_id as v31, note as v5, v45 from cast_info as ci, aggView8987161907298427303 where ci.movie_id=aggView8987161907298427303.v31 and note IN ('(producer)','(executive producer)'));
create or replace view aggJoin8210979815461224453 as (
with aggView4573085500359076460 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView4573085500359076460 where mi_idx.info_type_id=aggView4573085500359076460.v10);
create or replace view aggJoin4211998104363758629 as (
with aggView7711628683192726028 as (select v31, MIN(v20) as v44 from aggJoin8210979815461224453 group by v31)
select movie_id as v31, info_type_id as v8, info as v15, v44 from movie_info as mi, aggView7711628683192726028 where mi.movie_id=aggView7711628683192726028.v31);
create or replace view aggJoin2803999872456604000 as (
with aggView2120965903314706997 as (select id as v22 from name as n where gender= 'm' and name LIKE '%Tim%')
select v31, v5, v45 from aggJoin5173380698656692940 join aggView2120965903314706997 using(v22));
create or replace view aggJoin6777741418326791386 as (
with aggView6609291657555004973 as (select v31, MIN(v45) as v45 from aggJoin2803999872456604000 group by v31,v45)
select v8, v15, v44 as v44, v45 from aggJoin4211998104363758629 join aggView6609291657555004973 using(v31));
create or replace view aggJoin4261581958213666240 as (
with aggView3563707531303851399 as (select id as v8 from info_type as it1 where info= 'budget')
select v15, v44, v45 from aggJoin6777741418326791386 join aggView3563707531303851399 using(v8));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin4261581958213666240;
