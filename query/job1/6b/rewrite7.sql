create or replace view aggView754551522372820985 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8394798177634005701 as select movie_id as v23, v36 from cast_info as ci, aggView754551522372820985 where ci.person_id=aggView754551522372820985.v14;
create or replace view aggView2171249651347800035 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin1197980784449232149 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView2171249651347800035 where mk.movie_id=aggView2171249651347800035.v23;
create or replace view aggView7238046355380324249 as select v23, MIN(v36) as v36 from aggJoin8394798177634005701 group by v23;
create or replace view aggJoin5479323383149274067 as select v8, v37 as v37, v36 from aggJoin1197980784449232149 join aggView7238046355380324249 using(v23);
create or replace view aggView4856389821445438015 as select v8, MIN(v37) as v37, MIN(v36) as v36 from aggJoin5479323383149274067 group by v8;
create or replace view aggJoin5073665926523926454 as select keyword as v9, v37, v36 from keyword as k, aggView4856389821445438015 where k.id=aggView4856389821445438015.v8 and keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin5073665926523926454;
