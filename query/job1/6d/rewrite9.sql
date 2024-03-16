create or replace view aggView7724073368300482971 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin214833032213670883 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView7724073368300482971 where mk.movie_id=aggView7724073368300482971.v23;
create or replace view aggView6729359860462929903 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1669640023800961526 as select v23, v37 from aggJoin214833032213670883 join aggView6729359860462929903 using(v8);
create or replace view aggView5646422666773759515 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8201611731504880287 as select movie_id as v23, v36 from cast_info as ci, aggView5646422666773759515 where ci.person_id=aggView5646422666773759515.v14;
create or replace view aggView1604234412323316791 as select v23, MIN(v37) as v37 from aggJoin1669640023800961526 group by v23;
create or replace view aggJoin4496697174377495818 as select v36 as v36, v37 from aggJoin8201611731504880287 join aggView1604234412323316791 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4496697174377495818;
