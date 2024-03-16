create or replace view aggView5381641446474665013 as select id as v14, name as v36 from name as n;
create or replace view aggJoin7918295267133426092 as select movie_id as v23, v36 from cast_info as ci, aggView5381641446474665013 where ci.person_id=aggView5381641446474665013.v14;
create or replace view aggView6356212201587283962 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin3449363152909186820 as select movie_id as v23, v35 from movie_keyword as mk, aggView6356212201587283962 where mk.keyword_id=aggView6356212201587283962.v8;
create or replace view aggView7483652020002189053 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin8804117353088421749 as select v23, v35 from aggJoin3449363152909186820 join aggView7483652020002189053 using(v23);
create or replace view aggView7557786821673909634 as select v23, MIN(v35) as v35 from aggJoin8804117353088421749 group by v23;
create or replace view aggJoin19216573071758272 as select v36 as v36, v35 from aggJoin7918295267133426092 join aggView7557786821673909634 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin19216573071758272;
