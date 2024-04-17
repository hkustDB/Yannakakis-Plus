create or replace view aggView8851293905871180608 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2561114342992532498 as select movie_id as v23, v36 from cast_info as ci, aggView8851293905871180608 where ci.person_id=aggView8851293905871180608.v14;
create or replace view aggView8452243324024707925 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin2498845977824568493 as select v23, v36, v37 from aggJoin2561114342992532498 join aggView8452243324024707925 using(v23);
create or replace view aggView2548630639040797972 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin5473462412138577652 as select movie_id as v23, v35 from movie_keyword as mk, aggView2548630639040797972 where mk.keyword_id=aggView2548630639040797972.v8;
create or replace view aggView4518790082561126808 as select v23, MIN(v35) as v35 from aggJoin5473462412138577652 group by v23,v35;
create or replace view aggJoin507987888163626467 as select v36 as v36, v37 as v37, v35 from aggJoin2498845977824568493 join aggView4518790082561126808 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin507987888163626467;
