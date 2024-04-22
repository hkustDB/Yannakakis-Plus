create or replace view aggJoin5816073204034616794 as (
with aggView1587320526056096492 as (select id as v22 from name as n where gender= 'f')
select movie_id as v31, note as v5 from cast_info as ci, aggView1587320526056096492 where ci.person_id=aggView1587320526056096492.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin6961366053262941006 as (
with aggView4269924366964044288 as (select id as v10 from info_type as it2 where info= 'rating')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView4269924366964044288 where mi_idx.info_type_id=aggView4269924366964044288.v10 and info>'8.0');
create or replace view aggJoin2689736494562855960 as (
with aggView3026274373690897164 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView3026274373690897164 where mi.info_type_id=aggView3026274373690897164.v8 and info IN ('Horror','Thriller'));
create or replace view aggJoin7415939316700611152 as (
with aggView5138907986989586903 as (select v31, MIN(v15) as v43 from aggJoin2689736494562855960 group by v31)
select v31, v20, v43 from aggJoin6961366053262941006 join aggView5138907986989586903 using(v31));
create or replace view aggJoin7396321731864066697 as (
with aggView8950374821479018849 as (select v31, MIN(v43) as v43, MIN(v20) as v44 from aggJoin7415939316700611152 group by v31,v43)
select id as v31, title as v32, production_year as v35, v43, v44 from title as t, aggView8950374821479018849 where t.id=aggView8950374821479018849.v31 and production_year>=2008 and production_year<=2014);
create or replace view aggJoin1733263394710941303 as (
with aggView176860745213216032 as (select v31, MIN(v43) as v43, MIN(v44) as v44, MIN(v32) as v45 from aggJoin7396321731864066697 group by v31,v43,v44)
select v43, v44, v45 from aggJoin5816073204034616794 join aggView176860745213216032 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin1733263394710941303;
