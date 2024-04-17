create or replace view aggView5850651012732945352 as select id as v14, name as v36 from name as n;
create or replace view aggJoin3577851545998277461 as select movie_id as v23, v36 from cast_info as ci, aggView5850651012732945352 where ci.person_id=aggView5850651012732945352.v14;
create or replace view aggView4797606537408909523 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin3915988558299216897 as select movie_id as v23, v35 from movie_keyword as mk, aggView4797606537408909523 where mk.keyword_id=aggView4797606537408909523.v8;
create or replace view aggView3860394512969232616 as select v23, MIN(v35) as v35 from aggJoin3915988558299216897 group by v23,v35;
create or replace view aggJoin6449228649794052639 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView3860394512969232616 where t.id=aggView3860394512969232616.v23 and production_year>2000;
create or replace view aggView6909311426558923616 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin6449228649794052639 group by v23,v35;
create or replace view aggJoin4919663370711451878 as select v36 as v36, v35, v37 from aggJoin3577851545998277461 join aggView6909311426558923616 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4919663370711451878;
