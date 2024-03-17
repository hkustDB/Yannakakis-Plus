create or replace view aggView6767287664768400416 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin6989002643745601493 as select movie_id as v23, v36 from cast_info as ci, aggView6767287664768400416 where ci.person_id=aggView6767287664768400416.v14;
create or replace view aggView4782053304829188700 as select v23, MIN(v36) as v36 from aggJoin6989002643745601493 group by v23;
create or replace view aggJoin1738638894840268923 as select id as v23, title as v24, v36 from title as t, aggView4782053304829188700 where t.id=aggView4782053304829188700.v23 and production_year>2010;
create or replace view aggView3417130610904744539 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin1738638894840268923 group by v23;
create or replace view aggJoin5528675525074098100 as select keyword_id as v8, v36, v37 from movie_keyword as mk, aggView3417130610904744539 where mk.movie_id=aggView3417130610904744539.v23;
create or replace view aggView2836810638128555565 as select v8, MIN(v36) as v36, MIN(v37) as v37 from aggJoin5528675525074098100 group by v8;
create or replace view aggJoin560658090356398280 as select keyword as v9, v36, v37 from keyword as k, aggView2836810638128555565 where k.id=aggView2836810638128555565.v8 and keyword= 'marvel-cinematic-universe';
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin560658090356398280;
