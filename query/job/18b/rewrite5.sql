create or replace view aggView133703188113196582 as select title as v32, id as v31 from title as t where production_year>=2008 and production_year<=2014;
create or replace view aggJoin3532375124204475823 as (
with aggView2386524211299850243 as (select id as v22 from name as n where gender= 'f')
select movie_id as v31, note as v5 from cast_info as ci, aggView2386524211299850243 where ci.person_id=aggView2386524211299850243.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin7658102547138307580 as (
with aggView3999705140729636945 as (select v31 from aggJoin3532375124204475823 group by v31)
select movie_id as v31, info_type_id as v10, info as v20 from movie_info_idx as mi_idx, aggView3999705140729636945 where mi_idx.movie_id=aggView3999705140729636945.v31);
create or replace view aggJoin2720393729173139428 as (
with aggView1213110146701733695 as (select id as v10 from info_type as it2 where info= 'rating')
select v31, v20 from aggJoin7658102547138307580 join aggView1213110146701733695 using(v10));
create or replace view aggJoin4282115713121874405 as (
with aggView4181230144534935499 as (select v31, v20 from aggJoin2720393729173139428 group by v31,v20)
select v31, v20 from aggView4181230144534935499 where v20>'8.0');
create or replace view aggJoin3083242306499499128 as (
with aggView3322525456255894582 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView3322525456255894582 where mi.info_type_id=aggView3322525456255894582.v8 and info IN ('Horror','Thriller'));
create or replace view aggView5391037083404550468 as select v15, v31 from aggJoin3083242306499499128 group by v15,v31;
create or replace view aggJoin8842788051550771667 as (
with aggView2652510596950160634 as (select v31, MIN(v32) as v45 from aggView133703188113196582 group by v31)
select v31, v20, v45 from aggJoin4282115713121874405 join aggView2652510596950160634 using(v31));
create or replace view aggJoin9151115323470344610 as (
with aggView4413511274612860948 as (select v31, MIN(v45) as v45, MIN(v20) as v44 from aggJoin8842788051550771667 group by v31,v45)
select v15, v45, v44 from aggView5391037083404550468 join aggView4413511274612860948 using(v31));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin9151115323470344610;
