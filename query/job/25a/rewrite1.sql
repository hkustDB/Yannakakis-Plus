create or replace view aggView3100710190373362444 as select title as v38, id as v37 from title as t;
create or replace view aggView6522402153065699941 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggJoin5965405901887450955 as (
with aggView3815777855786426477 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView3815777855786426477 where mi_idx.info_type_id=aggView3815777855786426477.v10);
create or replace view aggJoin6723342538185553177 as (
with aggView1201566394266230087 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView1201566394266230087 where mi.info_type_id=aggView1201566394266230087.v8);
create or replace view aggJoin8132839814047524236 as (
with aggView832329521388174127 as (select v18, v37 from aggJoin6723342538185553177 group by v18,v37)
select v37, v18 from aggView832329521388174127 where v18= 'Horror');
create or replace view aggJoin324222723068302779 as (
with aggView1499245481556545787 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView1499245481556545787 where mk.keyword_id=aggView1499245481556545787.v12);
create or replace view aggJoin3777260908882383311 as (
with aggView5816607585761147452 as (select v37 from aggJoin324222723068302779 group by v37)
select v37, v23 from aggJoin5965405901887450955 join aggView5816607585761147452 using(v37));
create or replace view aggView7771348832724509124 as select v23, v37 from aggJoin3777260908882383311 group by v23,v37;
create or replace view aggJoin274430275282151510 as (
with aggView8453852726995305962 as (select v28, MIN(v29) as v51 from aggView6522402153065699941 group by v28)
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView8453852726995305962 where ci.person_id=aggView8453852726995305962.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin589048714504590108 as (
with aggView4988683546504370707 as (select v37, MIN(v18) as v49 from aggJoin8132839814047524236 group by v37)
select v37, v5, v51 as v51, v49 from aggJoin274430275282151510 join aggView4988683546504370707 using(v37));
create or replace view aggJoin3912699722876336469 as (
with aggView8081081742368384437 as (select v37, MIN(v51) as v51, MIN(v49) as v49 from aggJoin589048714504590108 group by v37,v51,v49)
select v38, v37, v51, v49 from aggView3100710190373362444 join aggView8081081742368384437 using(v37));
create or replace view aggJoin3617020237613716529 as (
with aggView6214778625997018252 as (select v37, MIN(v51) as v51, MIN(v49) as v49, MIN(v38) as v52 from aggJoin3912699722876336469 group by v37,v51,v49)
select v23, v51, v49, v52 from aggView7771348832724509124 join aggView6214778625997018252 using(v37));
select MIN(v49) as v49,MIN(v23) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin3617020237613716529;
