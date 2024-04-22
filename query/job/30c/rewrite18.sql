create or replace view aggJoin5085028813819306401 as (
with aggView5533549820146389725 as (select id as v45, title as v60 from title as t)
select movie_id as v45, subject_id as v5, status_id as v7, v60 from complete_cast as cc, aggView5533549820146389725 where cc.movie_id=aggView5533549820146389725.v45);
create or replace view aggJoin3507793295604491776 as (
with aggView8424473616274024603 as (select id as v36, name as v59 from name as n where gender= 'm')
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView8424473616274024603 where ci.person_id=aggView8424473616274024603.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5942071007583328785 as (
with aggView1522475294088522149 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView1522475294088522149 where mk.keyword_id=aggView1522475294088522149.v20);
create or replace view aggJoin6235443697858100786 as (
with aggView6462610446698927771 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select v45, v5, v60 from aggJoin5085028813819306401 join aggView6462610446698927771 using(v7));
create or replace view aggJoin1449146846354208949 as (
with aggView5002284595685666525 as (select v45, MIN(v59) as v59 from aggJoin3507793295604491776 group by v45,v59)
select movie_id as v45, info_type_id as v18, info as v31, v59 from movie_info_idx as mi_idx, aggView5002284595685666525 where mi_idx.movie_id=aggView5002284595685666525.v45);
create or replace view aggJoin4333781353212330 as (
with aggView1257099652998617367 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView1257099652998617367 where mi.info_type_id=aggView1257099652998617367.v16 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin2381613939067142461 as (
with aggView1058948208829421266 as (select v45, MIN(v26) as v57 from aggJoin4333781353212330 group by v45)
select v45, v18, v31, v59 as v59, v57 from aggJoin1449146846354208949 join aggView1058948208829421266 using(v45));
create or replace view aggJoin4833467217775763245 as (
with aggView4336460861528021634 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45, v60 from aggJoin6235443697858100786 join aggView4336460861528021634 using(v5));
create or replace view aggJoin2392677398653242580 as (
with aggView5753532110796319608 as (select v45, MIN(v60) as v60 from aggJoin4833467217775763245 group by v45,v60)
select v45, v18, v31, v59 as v59, v57 as v57, v60 from aggJoin2381613939067142461 join aggView5753532110796319608 using(v45));
create or replace view aggJoin3243693634585845256 as (
with aggView4469351709894703267 as (select id as v18 from info_type as it2 where info= 'votes')
select v45, v31, v59, v57, v60 from aggJoin2392677398653242580 join aggView4469351709894703267 using(v18));
create or replace view aggJoin4890826190986619654 as (
with aggView8195066432429757515 as (select v45, MIN(v59) as v59, MIN(v57) as v57, MIN(v60) as v60, MIN(v31) as v58 from aggJoin3243693634585845256 group by v45,v59,v57,v60)
select v59, v57, v60, v58 from aggJoin5942071007583328785 join aggView8195066432429757515 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin4890826190986619654;
