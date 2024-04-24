create or replace view aggView3615843158378205697 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin4581178477608084681 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView3615843158378205697 where ci.movie_id=aggView3615843158378205697.v23;
create or replace view aggView6641386035779582813 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin5543482107003154055 as select v23, v37, v36 from aggJoin4581178477608084681 join aggView6641386035779582813 using(v14);
create or replace view aggView1906682423162027885 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin7395795307180885913 as select movie_id as v23, v35 from movie_keyword as mk, aggView1906682423162027885 where mk.keyword_id=aggView1906682423162027885.v8;
create or replace view aggView5614478423721821723 as select v23, MIN(v35) as v35 from aggJoin7395795307180885913 group by v23,v35;
create or replace view aggJoin7406421466874672240 as select v37 as v37, v36 as v36, v35 from aggJoin5543482107003154055 join aggView5614478423721821723 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin7406421466874672240;
