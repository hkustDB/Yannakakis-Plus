create or replace view aggJoin3535339240912385613 as (
with aggView2961964340744185702 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView2961964340744185702 where mi_idx.info_type_id=aggView2961964340744185702.v10);
create or replace view aggJoin2021520093441609325 as (
with aggView889771037657280177 as (select v31, MIN(v20) as v44 from aggJoin3535339240912385613 group by v31)
select id as v31, title as v32, v44 from title as t, aggView889771037657280177 where t.id=aggView889771037657280177.v31);
create or replace view aggJoin6699543985575668368 as (
with aggView8930311724099447741 as (select v31, MIN(v44) as v44, MIN(v32) as v45 from aggJoin2021520093441609325 group by v31,v44)
select person_id as v22, movie_id as v31, note as v5, v44, v45 from cast_info as ci, aggView8930311724099447741 where ci.movie_id=aggView8930311724099447741.v31 and note IN ('(producer)','(executive producer)'));
create or replace view aggJoin8682169631919925593 as (
with aggView9094345989404700190 as (select id as v22 from name as n where gender= 'm' and name LIKE '%Tim%')
select v31, v5, v44, v45 from aggJoin6699543985575668368 join aggView9094345989404700190 using(v22));
create or replace view aggJoin6633373645392990219 as (
with aggView8809672344302529152 as (select v31, MIN(v44) as v44, MIN(v45) as v45 from aggJoin8682169631919925593 group by v31,v45,v44)
select info_type_id as v8, info as v15, v44, v45 from movie_info as mi, aggView8809672344302529152 where mi.movie_id=aggView8809672344302529152.v31);
create or replace view aggJoin7647666540394920134 as (
with aggView7881342140829654100 as (select id as v8 from info_type as it1 where info= 'budget')
select v15, v44, v45 from aggJoin6633373645392990219 join aggView7881342140829654100 using(v8));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin7647666540394920134;
