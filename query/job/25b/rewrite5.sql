create or replace view aggJoin1324933707577407084 as (
with aggView7372945647486436530 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView7372945647486436530 where ci.person_id=aggView7372945647486436530.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8583117882727095730 as (
with aggView7616492026295669841 as (select v37, MIN(v51) as v51 from aggJoin1324933707577407084 group by v37,v51)
select movie_id as v37, info_type_id as v10, info as v23, v51 from movie_info_idx as mi_idx, aggView7616492026295669841 where mi_idx.movie_id=aggView7616492026295669841.v37);
create or replace view aggJoin6786090488127365185 as (
with aggView939405084528016518 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView939405084528016518 where mi.info_type_id=aggView939405084528016518.v8 and info= 'Horror');
create or replace view aggJoin1183444591448636281 as (
with aggView362530414820769536 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView362530414820769536 where mk.keyword_id=aggView362530414820769536.v12);
create or replace view aggJoin163420272311384111 as (
with aggView4040005201425423851 as (select id as v10 from info_type as it2 where info= 'votes')
select v37, v23, v51 from aggJoin8583117882727095730 join aggView4040005201425423851 using(v10));
create or replace view aggJoin6064007407956594449 as (
with aggView273217583053988661 as (select v37, MIN(v51) as v51, MIN(v23) as v50 from aggJoin163420272311384111 group by v37,v51)
select v37, v18, v51, v50 from aggJoin6786090488127365185 join aggView273217583053988661 using(v37));
create or replace view aggJoin822856810995740007 as (
with aggView1484609281748341276 as (select v37, MIN(v51) as v51, MIN(v50) as v50, MIN(v18) as v49 from aggJoin6064007407956594449 group by v37,v50,v51)
select id as v37, title as v38, production_year as v41, v51, v50, v49 from title as t, aggView1484609281748341276 where t.id=aggView1484609281748341276.v37 and production_year>2010 and title LIKE 'Vampire%');
create or replace view aggJoin1632920116238749712 as (
with aggView6820537779495785065 as (select v37, MIN(v51) as v51, MIN(v50) as v50, MIN(v49) as v49, MIN(v38) as v52 from aggJoin822856810995740007 group by v37,v50,v49,v51)
select v51, v50, v49, v52 from aggJoin1183444591448636281 join aggView6820537779495785065 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin1632920116238749712;
