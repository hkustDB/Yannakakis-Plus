create or replace view aggView4960899631505915917 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin237957451318109101 as select movie_id as v23, v35 from movie_keyword as mk, aggView4960899631505915917 where mk.keyword_id=aggView4960899631505915917.v8;
create or replace view aggView6112724864803734463 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin3888143506223180486 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView6112724864803734463 where ci.movie_id=aggView6112724864803734463.v23;
create or replace view aggView1165825143810326845 as select v23, MIN(v35) as v35 from aggJoin237957451318109101 group by v23;
create or replace view aggJoin5357101969064957013 as select v14, v37 as v37, v35 from aggJoin3888143506223180486 join aggView1165825143810326845 using(v23);
create or replace view aggView1355483291079308513 as select v14, MIN(v37) as v37, MIN(v35) as v35 from aggJoin5357101969064957013 group by v14;
create or replace view aggJoin6893630660010966876 as select name as v15, v37, v35 from name as n, aggView1355483291079308513 where n.id=aggView1355483291079308513.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin6893630660010966876;
