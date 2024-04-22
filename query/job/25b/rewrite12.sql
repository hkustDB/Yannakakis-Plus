create or replace view aggJoin8551184936653527068 as (
with aggView7261910127879508295 as (select id as v37, title as v52 from title as t where production_year>2010 and title LIKE 'Vampire%')
select movie_id as v37, info_type_id as v10, info as v23, v52 from movie_info_idx as mi_idx, aggView7261910127879508295 where mi_idx.movie_id=aggView7261910127879508295.v37);
create or replace view aggJoin4870890594575917027 as (
with aggView9035995863539421106 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView9035995863539421106 where ci.person_id=aggView9035995863539421106.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8170258102589496576 as (
with aggView178486789768279786 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView178486789768279786 where mi.info_type_id=aggView178486789768279786.v8 and info= 'Horror');
create or replace view aggJoin6924646160461551817 as (
with aggView2544405627276948671 as (select v37, MIN(v18) as v49 from aggJoin8170258102589496576 group by v37)
select v37, v5, v51 as v51, v49 from aggJoin4870890594575917027 join aggView2544405627276948671 using(v37));
create or replace view aggJoin7622371014250940536 as (
with aggView8703700637913454448 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView8703700637913454448 where mk.keyword_id=aggView8703700637913454448.v12);
create or replace view aggJoin2986377744340612068 as (
with aggView8001300242526964760 as (select id as v10 from info_type as it2 where info= 'votes')
select v37, v23, v52 from aggJoin8551184936653527068 join aggView8001300242526964760 using(v10));
create or replace view aggJoin6688499286549030877 as (
with aggView7068962927119256216 as (select v37, MIN(v52) as v52, MIN(v23) as v50 from aggJoin2986377744340612068 group by v37,v52)
select v37, v52, v50 from aggJoin7622371014250940536 join aggView7068962927119256216 using(v37));
create or replace view aggJoin2588557934062531904 as (
with aggView5518803901341244992 as (select v37, MIN(v51) as v51, MIN(v49) as v49 from aggJoin6924646160461551817 group by v37,v51,v49)
select v52 as v52, v50 as v50, v51, v49 from aggJoin6688499286549030877 join aggView5518803901341244992 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin2588557934062531904;
