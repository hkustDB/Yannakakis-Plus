create or replace view aggView1173586153404521699 as select title as v32, id as v31 from title as t;
create or replace view aggJoin8162701368104791803 as (
with aggView8785594452069298958 as (select id as v22 from name as n where gender= 'm')
select movie_id as v31, note as v5 from cast_info as ci, aggView8785594452069298958 where ci.person_id=aggView8785594452069298958.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin4784051537543040484 as (
with aggView3197884233664487594 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView3197884233664487594 where mi.info_type_id=aggView3197884233664487594.v8);
create or replace view aggJoin6158319872694035545 as (
with aggView8430655493240425413 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView8430655493240425413 where mi_idx.info_type_id=aggView8430655493240425413.v10);
create or replace view aggView8056237403587430701 as select v31, v20 from aggJoin6158319872694035545 group by v31,v20;
create or replace view aggJoin625576331822181594 as (
with aggView3829484255627534972 as (select v31 from aggJoin8162701368104791803 group by v31)
select v31, v15 from aggJoin4784051537543040484 join aggView3829484255627534972 using(v31));
create or replace view aggJoin6433973924385788674 as (
with aggView1898763392850704064 as (select v31, v15 from aggJoin625576331822181594 group by v31,v15)
select v31, v15 from aggView1898763392850704064 where v15 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin4484420631789330417 as (
with aggView7582299962953712062 as (select v31, MIN(v15) as v43 from aggJoin6433973924385788674 group by v31)
select v31, v20, v43 from aggView8056237403587430701 join aggView7582299962953712062 using(v31));
create or replace view aggJoin8552578167754160792 as (
with aggView2970409412059530740 as (select v31, MIN(v43) as v43, MIN(v20) as v44 from aggJoin4484420631789330417 group by v31,v43)
select v32, v43, v44 from aggView1173586153404521699 join aggView2970409412059530740 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin8552578167754160792;
