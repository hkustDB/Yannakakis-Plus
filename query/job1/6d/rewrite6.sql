create or replace view aggView751731116577107013 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin450067220629529136 as select movie_id as v23, v36 from cast_info as ci, aggView751731116577107013 where ci.person_id=aggView751731116577107013.v14;
create or replace view aggView5153049798971543269 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin240348981768960213 as select movie_id as v23, v35 from movie_keyword as mk, aggView5153049798971543269 where mk.keyword_id=aggView5153049798971543269.v8;
create or replace view aggView302458608367238462 as select v23, MIN(v36) as v36 from aggJoin450067220629529136 group by v23;
create or replace view aggJoin915377252391167689 as select id as v23, title as v24, v36 from title as t, aggView302458608367238462 where t.id=aggView302458608367238462.v23 and production_year>2000;
create or replace view aggView8728650660651268875 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin915377252391167689 group by v23;
create or replace view aggJoin708712134878106248 as select v35 as v35, v36, v37 from aggJoin240348981768960213 join aggView8728650660651268875 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin708712134878106248;
