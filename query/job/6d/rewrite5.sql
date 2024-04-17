create or replace view aggView1306262434797259352 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin4950436344798196779 as select movie_id as v23, v35 from movie_keyword as mk, aggView1306262434797259352 where mk.keyword_id=aggView1306262434797259352.v8;
create or replace view aggView2090501107344181872 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin7423496500023524791 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView2090501107344181872 where ci.movie_id=aggView2090501107344181872.v23;
create or replace view aggView6483817710605503734 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3896396859342896 as select v23, v37, v36 from aggJoin7423496500023524791 join aggView6483817710605503734 using(v14);
create or replace view aggView8897713145644163599 as select v23, MIN(v35) as v35 from aggJoin4950436344798196779 group by v23,v35;
create or replace view aggJoin758612864763242626 as select v37 as v37, v36 as v36, v35 from aggJoin3896396859342896 join aggView8897713145644163599 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin758612864763242626;
