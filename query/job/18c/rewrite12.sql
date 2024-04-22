create or replace view aggJoin166025259649937777 as (
with aggView2338573394160571948 as (select id as v22 from name as n where gender= 'm')
select movie_id as v31, note as v5 from cast_info as ci, aggView2338573394160571948 where ci.person_id=aggView2338573394160571948.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5188575275700986861 as (
with aggView7746211485510578486 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView7746211485510578486 where mi.info_type_id=aggView7746211485510578486.v8 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin656450872609753331 as (
with aggView7314285357436273562 as (select v31, MIN(v15) as v43 from aggJoin5188575275700986861 group by v31)
select id as v31, title as v32, v43 from title as t, aggView7314285357436273562 where t.id=aggView7314285357436273562.v31);
create or replace view aggJoin1559611819476813210 as (
with aggView2284836329323105176 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView2284836329323105176 where mi_idx.info_type_id=aggView2284836329323105176.v10);
create or replace view aggJoin5734867066972726976 as (
with aggView4905363945683219531 as (select v31, MIN(v20) as v44 from aggJoin1559611819476813210 group by v31)
select v31, v5, v44 from aggJoin166025259649937777 join aggView4905363945683219531 using(v31));
create or replace view aggJoin3673468271358642069 as (
with aggView9217155248461936321 as (select v31, MIN(v44) as v44 from aggJoin5734867066972726976 group by v31,v44)
select v32, v43 as v43, v44 from aggJoin656450872609753331 join aggView9217155248461936321 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin3673468271358642069;
