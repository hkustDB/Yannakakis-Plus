create or replace view aggJoin3789960319228952289 as (
with aggView4365913705291961647 as (select id as v37, title as v52 from title as t where production_year>2010 and title LIKE 'Vampire%')
select movie_id as v37, info_type_id as v8, info as v18, v52 from movie_info as mi, aggView4365913705291961647 where mi.movie_id=aggView4365913705291961647.v37 and info= 'Horror');
create or replace view aggJoin1772681681650820761 as (
with aggView8757604243117498665 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView8757604243117498665 where ci.person_id=aggView8757604243117498665.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin384207811626920336 as (
with aggView4828962158335270225 as (select id as v8 from info_type as it1 where info= 'genres')
select v37, v18, v52 from aggJoin3789960319228952289 join aggView4828962158335270225 using(v8));
create or replace view aggJoin1348100025733928435 as (
with aggView1322039808097847178 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView1322039808097847178 where mk.keyword_id=aggView1322039808097847178.v12);
create or replace view aggJoin774259138542792783 as (
with aggView7550697117240619219 as (select v37, MIN(v51) as v51 from aggJoin1772681681650820761 group by v37,v51)
select v37, v18, v52 as v52, v51 from aggJoin384207811626920336 join aggView7550697117240619219 using(v37));
create or replace view aggJoin5723375464637763856 as (
with aggView4788463274904233539 as (select v37, MIN(v52) as v52, MIN(v51) as v51, MIN(v18) as v49 from aggJoin774259138542792783 group by v37,v51,v52)
select movie_id as v37, info_type_id as v10, info as v23, v52, v51, v49 from movie_info_idx as mi_idx, aggView4788463274904233539 where mi_idx.movie_id=aggView4788463274904233539.v37);
create or replace view aggJoin4321496576802382231 as (
with aggView2167048500022943385 as (select id as v10 from info_type as it2 where info= 'votes')
select v37, v23, v52, v51, v49 from aggJoin5723375464637763856 join aggView2167048500022943385 using(v10));
create or replace view aggJoin7612429253874945025 as (
with aggView8341264431650949503 as (select v37, MIN(v52) as v52, MIN(v51) as v51, MIN(v49) as v49, MIN(v23) as v50 from aggJoin4321496576802382231 group by v37,v51,v52,v49)
select v52, v51, v49, v50 from aggJoin1348100025733928435 join aggView8341264431650949503 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin7612429253874945025;
