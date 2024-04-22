create or replace view aggJoin4007131879322095739 as (
with aggView3853773839008836931 as (select id as v22 from name as n where gender= 'm')
select movie_id as v31, note as v5 from cast_info as ci, aggView3853773839008836931 where ci.person_id=aggView3853773839008836931.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin6159380047598799129 as (
with aggView2171563936440087339 as (select v31 from aggJoin4007131879322095739 group by v31)
select movie_id as v31, info_type_id as v10, info as v20 from movie_info_idx as mi_idx, aggView2171563936440087339 where mi_idx.movie_id=aggView2171563936440087339.v31);
create or replace view aggJoin6552577802139407254 as (
with aggView8381962380350425253 as (select id as v10 from info_type as it2 where info= 'votes')
select v31, v20 from aggJoin6159380047598799129 join aggView8381962380350425253 using(v10));
create or replace view aggJoin2954525267774095139 as (
with aggView361631655256430444 as (select v31, MIN(v20) as v44 from aggJoin6552577802139407254 group by v31)
select movie_id as v31, info_type_id as v8, info as v15, v44 from movie_info as mi, aggView361631655256430444 where mi.movie_id=aggView361631655256430444.v31 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin1960066290721522175 as (
with aggView2910961874568218796 as (select id as v8 from info_type as it1 where info= 'genres')
select v31, v15, v44 from aggJoin2954525267774095139 join aggView2910961874568218796 using(v8));
create or replace view aggJoin3212307550728743308 as (
with aggView4567821721539928558 as (select v31, MIN(v44) as v44, MIN(v15) as v43 from aggJoin1960066290721522175 group by v31,v44)
select title as v32, v44, v43 from title as t, aggView4567821721539928558 where t.id=aggView4567821721539928558.v31);
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin3212307550728743308;
