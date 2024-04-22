create or replace view aggJoin8001100853988657011 as (
with aggView494509339591404711 as (select id as v45, title as v60 from title as t)
select movie_id as v45, info_type_id as v18, info as v31, v60 from movie_info_idx as mi_idx, aggView494509339591404711 where mi_idx.movie_id=aggView494509339591404711.v45);
create or replace view aggJoin2008916414464810757 as (
with aggView7215890314878155986 as (select id as v36, name as v59 from name as n where gender= 'm')
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView7215890314878155986 where ci.person_id=aggView7215890314878155986.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin4083017819519333541 as (
with aggView7431935114776368729 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView7431935114776368729 where mk.keyword_id=aggView7431935114776368729.v20);
create or replace view aggJoin1159895483775861677 as (
with aggView5717645533129950022 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView5717645533129950022 where cc.status_id=aggView5717645533129950022.v7);
create or replace view aggJoin4848428134994968828 as (
with aggView1023680053103279727 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView1023680053103279727 where mi.info_type_id=aggView1023680053103279727.v16 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin6691067159604752095 as (
with aggView892881599343054154 as (select v45, MIN(v26) as v57 from aggJoin4848428134994968828 group by v45)
select v45, v57 from aggJoin4083017819519333541 join aggView892881599343054154 using(v45));
create or replace view aggJoin5924207039704462676 as (
with aggView4076653359279486566 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45 from aggJoin1159895483775861677 join aggView4076653359279486566 using(v5));
create or replace view aggJoin7622116355105815267 as (
with aggView929665702603205023 as (select v45 from aggJoin5924207039704462676 group by v45)
select v45, v57 as v57 from aggJoin6691067159604752095 join aggView929665702603205023 using(v45));
create or replace view aggJoin51350539387180241 as (
with aggView6708492169435513893 as (select id as v18 from info_type as it2 where info= 'votes')
select v45, v31, v60 from aggJoin8001100853988657011 join aggView6708492169435513893 using(v18));
create or replace view aggJoin4478925388542469413 as (
with aggView6443605557914568920 as (select v45, MIN(v60) as v60, MIN(v31) as v58 from aggJoin51350539387180241 group by v45,v60)
select v45, v13, v59 as v59, v60, v58 from aggJoin2008916414464810757 join aggView6443605557914568920 using(v45));
create or replace view aggJoin413391542488163799 as (
with aggView8988249105287882921 as (select v45, MIN(v59) as v59, MIN(v60) as v60, MIN(v58) as v58 from aggJoin4478925388542469413 group by v45,v59,v60,v58)
select v57 as v57, v59, v60, v58 from aggJoin7622116355105815267 join aggView8988249105287882921 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin413391542488163799;
