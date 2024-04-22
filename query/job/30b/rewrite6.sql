create or replace view aggView4206986994945293846 as select name as v37, id as v36 from name as n where gender= 'm';
create or replace view aggJoin7941307389157490937 as (
with aggView1765684398321242111 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView1765684398321242111 where cc.status_id=aggView1765684398321242111.v7);
create or replace view aggJoin5809612438613918480 as (
with aggView7746958497997981126 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView7746958497997981126 where mk.keyword_id=aggView7746958497997981126.v20);
create or replace view aggJoin7162774269448704618 as (
with aggView7558682966301314367 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView7558682966301314367 where mi.info_type_id=aggView7558682966301314367.v16);
create or replace view aggJoin4029926463315574869 as (
with aggView3481888196858776501 as (select v26, v45 from aggJoin7162774269448704618 group by v26,v45)
select v45, v26 from aggView3481888196858776501 where v26 IN ('Horror','Thriller'));
create or replace view aggJoin4799650023533232528 as (
with aggView5625931349380253566 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v45 from aggJoin7941307389157490937 join aggView5625931349380253566 using(v5));
create or replace view aggJoin2104692490962427842 as (
with aggView2338618387457113709 as (select v45 from aggJoin5809612438613918480 group by v45)
select id as v45, title as v46, production_year as v49 from title as t, aggView2338618387457113709 where t.id=aggView2338618387457113709.v45 and ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000);
create or replace view aggView1995966616497631756 as select v46, v45 from aggJoin2104692490962427842 group by v46,v45;
create or replace view aggJoin5320624453307035493 as (
with aggView6337243969443195679 as (select v45 from aggJoin4799650023533232528 group by v45)
select movie_id as v45, info_type_id as v18, info as v31 from movie_info_idx as mi_idx, aggView6337243969443195679 where mi_idx.movie_id=aggView6337243969443195679.v45);
create or replace view aggJoin6114683925532187014 as (
with aggView5302221955007698922 as (select id as v18 from info_type as it2 where info= 'votes')
select v45, v31 from aggJoin5320624453307035493 join aggView5302221955007698922 using(v18));
create or replace view aggView8293669580409011549 as select v31, v45 from aggJoin6114683925532187014 group by v31,v45;
create or replace view aggJoin3659778603078565289 as (
with aggView152153316522499752 as (select v45, MIN(v31) as v58 from aggView8293669580409011549 group by v45)
select v46, v45, v58 from aggView1995966616497631756 join aggView152153316522499752 using(v45));
create or replace view aggJoin6625240998268005844 as (
with aggView6833584069801998970 as (select v36, MIN(v37) as v59 from aggView4206986994945293846 group by v36)
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView6833584069801998970 where ci.person_id=aggView6833584069801998970.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin7171751656765364847 as (
with aggView45347289343855379 as (select v45, MIN(v59) as v59 from aggJoin6625240998268005844 group by v45,v59)
select v46, v45, v58 as v58, v59 from aggJoin3659778603078565289 join aggView45347289343855379 using(v45));
create or replace view aggJoin6975396153047074624 as (
with aggView4523852469599080892 as (select v45, MIN(v58) as v58, MIN(v59) as v59, MIN(v46) as v60 from aggJoin7171751656765364847 group by v45,v58,v59)
select v26, v58, v59, v60 from aggJoin4029926463315574869 join aggView4523852469599080892 using(v45));
select MIN(v26) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin6975396153047074624;
