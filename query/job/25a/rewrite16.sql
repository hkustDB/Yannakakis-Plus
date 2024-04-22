create or replace view aggJoin6129767259533448401 as (
with aggView6042119735310750094 as (select id as v37, title as v52 from title as t)
select movie_id as v37, info_type_id as v8, info as v18, v52 from movie_info as mi, aggView6042119735310750094 where mi.movie_id=aggView6042119735310750094.v37 and info= 'Horror');
create or replace view aggJoin3930136058944660519 as (
with aggView5022953255778470698 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView5022953255778470698 where ci.person_id=aggView5022953255778470698.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3921045642514075891 as (
with aggView6511486267479568032 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView6511486267479568032 where mi_idx.info_type_id=aggView6511486267479568032.v10);
create or replace view aggJoin6657149663067362719 as (
with aggView3394888331383904095 as (select v37, MIN(v23) as v50 from aggJoin3921045642514075891 group by v37)
select v37, v5, v51 as v51, v50 from aggJoin3930136058944660519 join aggView3394888331383904095 using(v37));
create or replace view aggJoin5674448228978398377 as (
with aggView5938490123345511735 as (select v37, MIN(v51) as v51, MIN(v50) as v50 from aggJoin6657149663067362719 group by v37,v51,v50)
select v37, v8, v18, v52 as v52, v51, v50 from aggJoin6129767259533448401 join aggView5938490123345511735 using(v37));
create or replace view aggJoin1916752688947243458 as (
with aggView6325632583609447444 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView6325632583609447444 where mk.keyword_id=aggView6325632583609447444.v12);
create or replace view aggJoin7474335369390550981 as (
with aggView7539259685594178512 as (select id as v8 from info_type as it1 where info= 'genres')
select v37, v18, v52, v51, v50 from aggJoin5674448228978398377 join aggView7539259685594178512 using(v8));
create or replace view aggJoin3818665993512947919 as (
with aggView7934026677366648566 as (select v37, MIN(v52) as v52, MIN(v51) as v51, MIN(v50) as v50, MIN(v18) as v49 from aggJoin7474335369390550981 group by v37,v51,v52,v50)
select v52, v51, v50, v49 from aggJoin1916752688947243458 join aggView7934026677366648566 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin3818665993512947919;
