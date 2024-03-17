create or replace view aggView8015240583019269392 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin3055736950110463466 as select movie_id as v23, v35 from movie_keyword as mk, aggView8015240583019269392 where mk.keyword_id=aggView8015240583019269392.v8;
create or replace view aggView1690989807770014793 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2774773250588834176 as select movie_id as v23, v36 from cast_info as ci, aggView1690989807770014793 where ci.person_id=aggView1690989807770014793.v14;
create or replace view aggView4305797858887338429 as select v23, MIN(v35) as v35 from aggJoin3055736950110463466 group by v23;
create or replace view aggJoin277125805358323445 as select id as v23, title as v24, v35 from title as t, aggView4305797858887338429 where t.id=aggView4305797858887338429.v23 and production_year>2010;
create or replace view aggView306453467095974576 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin277125805358323445 group by v23;
create or replace view aggJoin60961520820192427 as select v36 as v36, v35, v37 from aggJoin2774773250588834176 join aggView306453467095974576 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin60961520820192427;
