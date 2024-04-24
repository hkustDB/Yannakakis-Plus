create or replace view aggView7844047752731839777 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin3580938255990416206 as select movie_id as v23, v35 from movie_keyword as mk, aggView7844047752731839777 where mk.keyword_id=aggView7844047752731839777.v8;
create or replace view aggView4471507229109114912 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin5825302866931181822 as select movie_id as v23, v36 from cast_info as ci, aggView4471507229109114912 where ci.person_id=aggView4471507229109114912.v14;
create or replace view aggView3431672820299868713 as select v23, MIN(v35) as v35 from aggJoin3580938255990416206 group by v23,v35;
create or replace view aggJoin2240861414584927591 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView3431672820299868713 where t.id=aggView3431672820299868713.v23 and production_year>2014;
create or replace view aggView8116884070242860763 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin2240861414584927591 group by v23,v35;
create or replace view aggJoin5498269806872955308 as select v36 as v36, v35, v37 from aggJoin5825302866931181822 join aggView8116884070242860763 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin5498269806872955308;
