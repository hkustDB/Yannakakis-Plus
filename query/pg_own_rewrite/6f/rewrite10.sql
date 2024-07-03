create or replace view aggView5338642047150758303 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin8487124125437212686 as select movie_id as v23, v35 from movie_keyword as mk, aggView5338642047150758303 where mk.keyword_id=aggView5338642047150758303.v8;
create or replace view aggView1366601353038323566 as select v23, MIN(v35) as v35 from aggJoin8487124125437212686 group by v23,v35;
create or replace view aggJoin350815420177841819 as select person_id as v14, movie_id as v23, v35 from cast_info as ci, aggView1366601353038323566 where ci.movie_id=aggView1366601353038323566.v23;
create or replace view aggView593089944506219368 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin5290622459334227698 as select v14, v35, v37 from aggJoin350815420177841819 join aggView593089944506219368 using(v23);
create or replace view aggView7659086496715629287 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin5290622459334227698 group by v14,v37,v35;
create or replace view aggJoin5474001104839499428 as select name as v15, v35, v37 from name as n, aggView7659086496715629287 where n.id=aggView7659086496715629287.v14;
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin5474001104839499428;
