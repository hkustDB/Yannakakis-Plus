create or replace view aggView5183679090319492842 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin5332118828024698079 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView5183679090319492842 where ci.movie_id=aggView5183679090319492842.v23;
create or replace view aggView3799687348790951610 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4307390129029516509 as select v23, v37, v36 from aggJoin5332118828024698079 join aggView3799687348790951610 using(v14);
create or replace view aggView1169407187790013633 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7461863221443444033 as select movie_id as v23, v35 from movie_keyword as mk, aggView1169407187790013633 where mk.keyword_id=aggView1169407187790013633.v8;
create or replace view aggView9140150228549243735 as select v23, MIN(v37) as v37, MIN(v36) as v36 from aggJoin4307390129029516509 group by v23;
create or replace view aggJoin551521061105007131 as select v35 as v35, v37, v36 from aggJoin7461863221443444033 join aggView9140150228549243735 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin551521061105007131;
