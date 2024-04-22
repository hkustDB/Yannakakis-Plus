create or replace view aggView5197095539686058651 as select title as v46, id as v45 from title as t where ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000;
create or replace view aggView2753327054632540403 as select name as v37, id as v36 from name as n where gender= 'm';
create or replace view aggJoin4547949608341312559 as (
with aggView4329849571445200384 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView4329849571445200384 where mi.info_type_id=aggView4329849571445200384.v16);
create or replace view aggJoin5616084028828569852 as (
with aggView2142803046234491305 as (select v26, v45 from aggJoin4547949608341312559 group by v26,v45)
select v45, v26 from aggView2142803046234491305 where v26 IN ('Horror','Thriller'));
create or replace view aggJoin2114562968723943808 as (
with aggView2763646593713919052 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView2763646593713919052 where mi_idx.info_type_id=aggView2763646593713919052.v18);
create or replace view aggView7213027439693095616 as select v31, v45 from aggJoin2114562968723943808 group by v31,v45;
create or replace view aggJoin3914428537872239250 as (
with aggView3967513520152380127 as (select v36, MIN(v37) as v59 from aggView2753327054632540403 group by v36)
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView3967513520152380127 where ci.person_id=aggView3967513520152380127.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3984448682028884779 as (
with aggView7652194392879959668 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView7652194392879959668 where cc.status_id=aggView7652194392879959668.v7);
create or replace view aggJoin8734658571048733044 as (
with aggView8657211995972726921 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView8657211995972726921 where mk.keyword_id=aggView8657211995972726921.v20);
create or replace view aggJoin8648781389643185855 as (
with aggView816232801552045227 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v45 from aggJoin3984448682028884779 join aggView816232801552045227 using(v5));
create or replace view aggJoin6731097138540318508 as (
with aggView7499283589459284825 as (select v45 from aggJoin8648781389643185855 group by v45)
select v45 from aggJoin8734658571048733044 join aggView7499283589459284825 using(v45));
create or replace view aggJoin2156752176189513367 as (
with aggView2910740047740301520 as (select v45 from aggJoin6731097138540318508 group by v45)
select v45, v13, v59 as v59 from aggJoin3914428537872239250 join aggView2910740047740301520 using(v45));
create or replace view aggJoin1577377427646904066 as (
with aggView771614541054143350 as (select v45, MIN(v59) as v59 from aggJoin2156752176189513367 group by v45,v59)
select v31, v45, v59 from aggView7213027439693095616 join aggView771614541054143350 using(v45));
create or replace view aggJoin618262155041224386 as (
with aggView5675466976199797258 as (select v45, MIN(v59) as v59, MIN(v31) as v58 from aggJoin1577377427646904066 group by v45,v59)
select v45, v26, v59, v58 from aggJoin5616084028828569852 join aggView5675466976199797258 using(v45));
create or replace view aggJoin340267866909973007 as (
with aggView9191712906177599470 as (select v45, MIN(v59) as v59, MIN(v58) as v58, MIN(v26) as v57 from aggJoin618262155041224386 group by v45,v58,v59)
select v46, v59, v58, v57 from aggView5197095539686058651 join aggView9191712906177599470 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v46) as v60 from aggJoin340267866909973007;
