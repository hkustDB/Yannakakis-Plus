create or replace view aggJoin8206157756275830149 as (
with aggView2373724358938588432 as (select id as v31, title as v45 from title as t)
select movie_id as v31, info_type_id as v10, info as v20, v45 from movie_info_idx as mi_idx, aggView2373724358938588432 where mi_idx.movie_id=aggView2373724358938588432.v31);
create or replace view aggJoin3668713763817760447 as (
with aggView8107477791546561217 as (select id as v10 from info_type as it2 where info= 'votes')
select v31, v20, v45 from aggJoin8206157756275830149 join aggView8107477791546561217 using(v10));
create or replace view aggJoin2404455417912703157 as (
with aggView4777978438777334372 as (select v31, MIN(v45) as v45, MIN(v20) as v44 from aggJoin3668713763817760447 group by v31,v45)
select person_id as v22, movie_id as v31, note as v5, v45, v44 from cast_info as ci, aggView4777978438777334372 where ci.movie_id=aggView4777978438777334372.v31 and note IN ('(producer)','(executive producer)'));
create or replace view aggJoin1644529685687462241 as (
with aggView3878178750351277244 as (select id as v22 from name as n where gender= 'm' and name LIKE '%Tim%')
select v31, v5, v45, v44 from aggJoin2404455417912703157 join aggView3878178750351277244 using(v22));
create or replace view aggJoin1909256821252345488 as (
with aggView4669380040619400157 as (select v31, MIN(v45) as v45, MIN(v44) as v44 from aggJoin1644529685687462241 group by v31,v45,v44)
select info_type_id as v8, info as v15, v45, v44 from movie_info as mi, aggView4669380040619400157 where mi.movie_id=aggView4669380040619400157.v31);
create or replace view aggJoin3511022309370354191 as (
with aggView1297483565663891560 as (select id as v8 from info_type as it1 where info= 'budget')
select v15, v45, v44 from aggJoin1909256821252345488 join aggView1297483565663891560 using(v8));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin3511022309370354191;
