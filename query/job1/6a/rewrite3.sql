create or replace view aggView3548026946579175046 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin5821601463219684329 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView3548026946579175046 where mk.movie_id=aggView3548026946579175046.v23;
create or replace view aggView7473160651691944300 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin3473093075587956221 as select v23, v37 from aggJoin5821601463219684329 join aggView7473160651691944300 using(v8);
create or replace view aggView8581089922384790811 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin191530939095854625 as select movie_id as v23, v36 from cast_info as ci, aggView8581089922384790811 where ci.person_id=aggView8581089922384790811.v14;
create or replace view aggView5183040212139160996 as select v23, MIN(v37) as v37 from aggJoin3473093075587956221 group by v23;
create or replace view aggJoin392537806629126515 as select v36 as v36, v37 from aggJoin191530939095854625 join aggView5183040212139160996 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin392537806629126515;
