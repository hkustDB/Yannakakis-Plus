create or replace view aggView2746581216814939938 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8640034846474418551 as select movie_id as v23, v36 from cast_info as ci, aggView2746581216814939938 where ci.person_id=aggView2746581216814939938.v14;
create or replace view aggView4620657124864911596 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin4913185536785377968 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView4620657124864911596 where mk.movie_id=aggView4620657124864911596.v23;
create or replace view aggView5178038009730989701 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4590401335928060469 as select v23, v37 from aggJoin4913185536785377968 join aggView5178038009730989701 using(v8);
create or replace view aggView8054913983110630782 as select v23, MIN(v36) as v36 from aggJoin8640034846474418551 group by v23;
create or replace view aggJoin1166248457938304184 as select v37 as v37, v36 from aggJoin4590401335928060469 join aggView8054913983110630782 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1166248457938304184;
