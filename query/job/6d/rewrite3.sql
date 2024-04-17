create or replace view aggView2207010506803328501 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin5704473112587489528 as select movie_id as v23, v35 from movie_keyword as mk, aggView2207010506803328501 where mk.keyword_id=aggView2207010506803328501.v8;
create or replace view aggView2411089089260085606 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin6024887836237512144 as select v23, v35, v37 from aggJoin5704473112587489528 join aggView2411089089260085606 using(v23);
create or replace view aggView3291654941038940133 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2775307125357553396 as select movie_id as v23, v36 from cast_info as ci, aggView3291654941038940133 where ci.person_id=aggView3291654941038940133.v14;
create or replace view aggView9076668686288881864 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin6024887836237512144 group by v23,v35,v37;
create or replace view aggJoin6070473565477764450 as select v36 as v36, v35, v37 from aggJoin2775307125357553396 join aggView9076668686288881864 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin6070473565477764450;
