create or replace view aggView678903138791689729 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin5153990315060249588 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView678903138791689729 where mk.movie_id=aggView678903138791689729.v23;
create or replace view aggView5065260264146382154 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4445900577603190025 as select v23, v37, v35 from aggJoin5153990315060249588 join aggView5065260264146382154 using(v8);
create or replace view aggView4823114043067725578 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1359381454675578811 as select movie_id as v23, v36 from cast_info as ci, aggView4823114043067725578 where ci.person_id=aggView4823114043067725578.v14;
create or replace view aggView8416878466906826848 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin4445900577603190025 group by v23,v35,v37;
create or replace view aggJoin5821964172141263426 as select v36 as v36, v37, v35 from aggJoin1359381454675578811 join aggView8416878466906826848 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin5821964172141263426;
