create or replace view aggJoin5968145091726439607 as (
with aggView6171098789143355920 as (select id as v36, name as v59 from name as n where gender= 'm')
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView6171098789143355920 where ci.person_id=aggView6171098789143355920.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin1645709541271981137 as (
with aggView1477767408760104392 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView1477767408760104392 where mk.keyword_id=aggView1477767408760104392.v20);
create or replace view aggJoin213819627696227437 as (
with aggView9109270779993924938 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView9109270779993924938 where cc.status_id=aggView9109270779993924938.v7);
create or replace view aggJoin7147959512438847822 as (
with aggView5085556469776920398 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView5085556469776920398 where mi.info_type_id=aggView5085556469776920398.v16 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin8971970520606811907 as (
with aggView1510288434991138289 as (select v45, MIN(v26) as v57 from aggJoin7147959512438847822 group by v45)
select id as v45, title as v46, v57 from title as t, aggView1510288434991138289 where t.id=aggView1510288434991138289.v45);
create or replace view aggJoin2645607455855481317 as (
with aggView6559372774400774023 as (select v45, MIN(v57) as v57, MIN(v46) as v60 from aggJoin8971970520606811907 group by v45,v57)
select movie_id as v45, info_type_id as v18, info as v31, v57, v60 from movie_info_idx as mi_idx, aggView6559372774400774023 where mi_idx.movie_id=aggView6559372774400774023.v45);
create or replace view aggJoin8607768021895504440 as (
with aggView6291546481054039620 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45 from aggJoin213819627696227437 join aggView6291546481054039620 using(v5));
create or replace view aggJoin8741793092560012409 as (
with aggView3975489250108255121 as (select id as v18 from info_type as it2 where info= 'votes')
select v45, v31, v57, v60 from aggJoin2645607455855481317 join aggView3975489250108255121 using(v18));
create or replace view aggJoin2952657620645954323 as (
with aggView1184086314514662317 as (select v45, MIN(v57) as v57, MIN(v60) as v60, MIN(v31) as v58 from aggJoin8741793092560012409 group by v45,v57,v60)
select v45, v57, v60, v58 from aggJoin8607768021895504440 join aggView1184086314514662317 using(v45));
create or replace view aggJoin4366751729493338392 as (
with aggView4508715157173190394 as (select v45, MIN(v57) as v57, MIN(v60) as v60, MIN(v58) as v58 from aggJoin2952657620645954323 group by v45,v57,v60,v58)
select v45, v13, v59 as v59, v57, v60, v58 from aggJoin5968145091726439607 join aggView4508715157173190394 using(v45));
create or replace view aggJoin2682405617119538141 as (
with aggView477081880567950745 as (select v45, MIN(v59) as v59, MIN(v57) as v57, MIN(v60) as v60, MIN(v58) as v58 from aggJoin4366751729493338392 group by v45,v59,v57,v60,v58)
select v59, v57, v60, v58 from aggJoin1645709541271981137 join aggView477081880567950745 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin2682405617119538141;
