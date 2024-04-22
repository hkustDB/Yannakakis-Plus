create or replace view aggView2771309853505457210 as select title as v32, id as v31 from title as t;
create or replace view aggJoin1129887253703460092 as (
with aggView2582963765663640653 as (select id as v22 from name as n where gender= 'm')
select movie_id as v31, note as v5 from cast_info as ci, aggView2582963765663640653 where ci.person_id=aggView2582963765663640653.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3303890883602999487 as (
with aggView5012724390741255576 as (select v31 from aggJoin1129887253703460092 group by v31)
select movie_id as v31, info_type_id as v10, info as v20 from movie_info_idx as mi_idx, aggView5012724390741255576 where mi_idx.movie_id=aggView5012724390741255576.v31);
create or replace view aggJoin5576834641362616027 as (
with aggView2417516706617722269 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView2417516706617722269 where mi.info_type_id=aggView2417516706617722269.v8);
create or replace view aggJoin4001429287670665843 as (
with aggView840668345023780373 as (select v31, v15 from aggJoin5576834641362616027 group by v31,v15)
select v31, v15 from aggView840668345023780373 where v15 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin720093209770143781 as (
with aggView1690380476518411606 as (select id as v10 from info_type as it2 where info= 'votes')
select v31, v20 from aggJoin3303890883602999487 join aggView1690380476518411606 using(v10));
create or replace view aggView472687704276109537 as select v31, v20 from aggJoin720093209770143781 group by v31,v20;
create or replace view aggJoin2638330815833534498 as (
with aggView3830692942715498277 as (select v31, MIN(v15) as v43 from aggJoin4001429287670665843 group by v31)
select v31, v20, v43 from aggView472687704276109537 join aggView3830692942715498277 using(v31));
create or replace view aggJoin8866510390332338305 as (
with aggView1138052514344006177 as (select v31, MIN(v43) as v43, MIN(v20) as v44 from aggJoin2638330815833534498 group by v31,v43)
select v32, v43, v44 from aggView2771309853505457210 join aggView1138052514344006177 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin8866510390332338305;
