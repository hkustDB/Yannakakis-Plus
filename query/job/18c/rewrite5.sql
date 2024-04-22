create or replace view aggView1379676179985674581 as select title as v32, id as v31 from title as t;
create or replace view aggJoin320279238294310159 as (
with aggView3522936486256483680 as (select id as v22 from name as n where gender= 'm')
select movie_id as v31, note as v5 from cast_info as ci, aggView3522936486256483680 where ci.person_id=aggView3522936486256483680.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin6976680266590400505 as (
with aggView22606530722397522 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView22606530722397522 where mi.info_type_id=aggView22606530722397522.v8);
create or replace view aggJoin862751771642127654 as (
with aggView3580034296389633552 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView3580034296389633552 where mi_idx.info_type_id=aggView3580034296389633552.v10);
create or replace view aggView2585377729260113403 as select v31, v20 from aggJoin862751771642127654 group by v31,v20;
create or replace view aggJoin9184461894609647904 as (
with aggView9058859957538254840 as (select v31 from aggJoin320279238294310159 group by v31)
select v31, v15 from aggJoin6976680266590400505 join aggView9058859957538254840 using(v31));
create or replace view aggJoin3395699324507219109 as (
with aggView7717931580262329792 as (select v31, v15 from aggJoin9184461894609647904 group by v31,v15)
select v31, v15 from aggView7717931580262329792 where v15 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin5062284000578027180 as (
with aggView4814346602948002542 as (select v31, MIN(v15) as v43 from aggJoin3395699324507219109 group by v31)
select v32, v31, v43 from aggView1379676179985674581 join aggView4814346602948002542 using(v31));
create or replace view aggJoin5442980372082864787 as (
with aggView8751175942867433609 as (select v31, MIN(v43) as v43, MIN(v32) as v45 from aggJoin5062284000578027180 group by v31,v43)
select v20, v43, v45 from aggView2585377729260113403 join aggView8751175942867433609 using(v31));
select MIN(v43) as v43,MIN(v20) as v44,MIN(v45) as v45 from aggJoin5442980372082864787;
