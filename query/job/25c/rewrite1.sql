create or replace view aggView4661209401960642587 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggView1369630537940147043 as select id as v37, title as v38 from title as t;
create or replace view aggJoin7670937985822675119 as (
with aggView5764324569728348655 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView5764324569728348655 where mi_idx.info_type_id=aggView5764324569728348655.v10);
create or replace view aggJoin1079603638263033774 as (
with aggView2355644570872471090 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView2355644570872471090 where mi.info_type_id=aggView2355644570872471090.v8);
create or replace view aggJoin5056549606224210473 as (
with aggView7518526008735994162 as (select v37, v18 from aggJoin1079603638263033774 group by v37,v18)
select v37, v18 from aggView7518526008735994162 where v18 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin4972592401654131617 as (
with aggView917865790273499352 as (select id as v12 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v37 from movie_keyword as mk, aggView917865790273499352 where mk.keyword_id=aggView917865790273499352.v12);
create or replace view aggJoin5857924863252217120 as (
with aggView909744580688567711 as (select v37 from aggJoin4972592401654131617 group by v37)
select v37, v23 from aggJoin7670937985822675119 join aggView909744580688567711 using(v37));
create or replace view aggView7306273451676589136 as select v37, v23 from aggJoin5857924863252217120 group by v37,v23;
create or replace view aggJoin6401770569042015743 as (
with aggView5668151910038940861 as (select v37, MIN(v18) as v49 from aggJoin5056549606224210473 group by v37)
select v37, v23, v49 from aggView7306273451676589136 join aggView5668151910038940861 using(v37));
create or replace view aggJoin8245868472179723553 as (
with aggView410356857775779585 as (select v37, MIN(v49) as v49, MIN(v23) as v50 from aggJoin6401770569042015743 group by v37,v49)
select v37, v38, v49, v50 from aggView1369630537940147043 join aggView410356857775779585 using(v37));
create or replace view aggJoin7625181365528570195 as (
with aggView3521843180782283358 as (select v37, MIN(v49) as v49, MIN(v50) as v50, MIN(v38) as v52 from aggJoin8245868472179723553 group by v37,v49,v50)
select person_id as v28, note as v5, v49, v50, v52 from cast_info as ci, aggView3521843180782283358 where ci.movie_id=aggView3521843180782283358.v37 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin6590803687201511704 as (
with aggView1218955458265243035 as (select v28, MIN(v49) as v49, MIN(v50) as v50, MIN(v52) as v52 from aggJoin7625181365528570195 group by v28,v49,v50,v52)
select v29, v49, v50, v52 from aggView4661209401960642587 join aggView1218955458265243035 using(v28));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v29) as v51,MIN(v52) as v52 from aggJoin6590803687201511704;
