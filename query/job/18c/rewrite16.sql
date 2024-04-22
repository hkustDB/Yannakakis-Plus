create or replace view aggJoin1584549393045972915 as (
with aggView2976126438133266329 as (select id as v22 from name as n where gender= 'm')
select movie_id as v31, note as v5 from cast_info as ci, aggView2976126438133266329 where ci.person_id=aggView2976126438133266329.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5060492296243516119 as (
with aggView8984911850995108748 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView8984911850995108748 where mi_idx.info_type_id=aggView8984911850995108748.v10);
create or replace view aggJoin6586364142244185366 as (
with aggView3370490515119311050 as (select v31, MIN(v20) as v44 from aggJoin5060492296243516119 group by v31)
select movie_id as v31, info_type_id as v8, info as v15, v44 from movie_info as mi, aggView3370490515119311050 where mi.movie_id=aggView3370490515119311050.v31 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin6378463122905155478 as (
with aggView1573322494294014803 as (select id as v8 from info_type as it1 where info= 'genres')
select v31, v15, v44 from aggJoin6586364142244185366 join aggView1573322494294014803 using(v8));
create or replace view aggJoin4466469957091375049 as (
with aggView1608014240711359689 as (select v31, MIN(v44) as v44, MIN(v15) as v43 from aggJoin6378463122905155478 group by v31,v44)
select id as v31, title as v32, v44, v43 from title as t, aggView1608014240711359689 where t.id=aggView1608014240711359689.v31);
create or replace view aggJoin7810609018840787372 as (
with aggView1688286680417287751 as (select v31 from aggJoin1584549393045972915 group by v31)
select v32, v44 as v44, v43 as v43 from aggJoin4466469957091375049 join aggView1688286680417287751 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin7810609018840787372;
