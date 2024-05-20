create or replace view aggView736741906208403860 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin2400065539383040716 as select movie_id as v23, v35 from movie_keyword as mk, aggView736741906208403860 where mk.keyword_id=aggView736741906208403860.v8;
create or replace view aggView9216292456241063990 as select v23, MIN(v35) as v35 from aggJoin2400065539383040716 group by v23;
create or replace view aggJoin3876407617499233577 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView9216292456241063990 where t.id=aggView9216292456241063990.v23 and production_year>2000;
create or replace view aggView4347926437951593205 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin3876407617499233577 group by v23;
create or replace view aggJoin945860129697701027 as select person_id as v14, v35, v37 from cast_info as ci, aggView4347926437951593205 where ci.movie_id=aggView4347926437951593205.v23;
create or replace view aggView7165014989857734294 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin945860129697701027 group by v14;
create or replace view aggJoin6464435817635836882 as select name as v15, v35, v37 from name as n, aggView7165014989857734294 where n.id=aggView7165014989857734294.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin6464435817635836882;
