create or replace view aggView8135526217294786534 as select title as v32, id as v31 from title as t;
create or replace view aggJoin1559259523586006509 as (
with aggView4396936304056104257 as (select id as v22 from name as n where gender= 'm')
select movie_id as v31, note as v5 from cast_info as ci, aggView4396936304056104257 where ci.person_id=aggView4396936304056104257.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin4789773023677932107 as (
with aggView3204597034787457730 as (select v31 from aggJoin1559259523586006509 group by v31)
select movie_id as v31, info_type_id as v10, info as v20 from movie_info_idx as mi_idx, aggView3204597034787457730 where mi_idx.movie_id=aggView3204597034787457730.v31);
create or replace view aggJoin5964081788814356948 as (
with aggView3132777871629169068 as (select id as v10 from info_type as it2 where info= 'votes')
select v31, v20 from aggJoin4789773023677932107 join aggView3132777871629169068 using(v10));
create or replace view aggView8964010726170574583 as select v31, v20 from aggJoin5964081788814356948 group by v31,v20;
create or replace view aggJoin831033547482075241 as (
with aggView2072998596853830022 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView2072998596853830022 where mi.info_type_id=aggView2072998596853830022.v8);
create or replace view aggJoin1800877076140952711 as (
with aggView3068429913218891382 as (select v31, v15 from aggJoin831033547482075241 group by v31,v15)
select v31, v15 from aggView3068429913218891382 where v15 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin5383237451511971923 as (
with aggView4685189467665312335 as (select v31, MIN(v32) as v45 from aggView8135526217294786534 group by v31)
select v31, v20, v45 from aggView8964010726170574583 join aggView4685189467665312335 using(v31));
create or replace view aggJoin1854277467261407952 as (
with aggView8523311267578320024 as (select v31, MIN(v45) as v45, MIN(v20) as v44 from aggJoin5383237451511971923 group by v31,v45)
select v15, v45, v44 from aggJoin1800877076140952711 join aggView8523311267578320024 using(v31));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin1854277467261407952;
