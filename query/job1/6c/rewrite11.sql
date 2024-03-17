create or replace view aggView3542496252578221998 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin2604723012127654232 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView3542496252578221998 where ci.movie_id=aggView3542496252578221998.v23;
create or replace view aggView1398812147447957209 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8843777216369009010 as select v23, v37, v36 from aggJoin2604723012127654232 join aggView1398812147447957209 using(v14);
create or replace view aggView1396032958296461169 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin2702101310230114829 as select movie_id as v23, v35 from movie_keyword as mk, aggView1396032958296461169 where mk.keyword_id=aggView1396032958296461169.v8;
create or replace view aggView4875141048503123348 as select v23, MIN(v37) as v37, MIN(v36) as v36 from aggJoin8843777216369009010 group by v23;
create or replace view aggJoin4162318407694510489 as select v35 as v35, v37, v36 from aggJoin2702101310230114829 join aggView4875141048503123348 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4162318407694510489;
