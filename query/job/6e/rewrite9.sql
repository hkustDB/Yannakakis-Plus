create or replace view aggView8520090967450143914 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3802871697506945219 as select movie_id as v23, v36 from cast_info as ci, aggView8520090967450143914 where ci.person_id=aggView8520090967450143914.v14;
create or replace view aggView8281995960804629179 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin1207364429679164483 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView8281995960804629179 where mk.movie_id=aggView8281995960804629179.v23;
create or replace view aggView1640388998538903220 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4234074772449542064 as select v23, v37, v35 from aggJoin1207364429679164483 join aggView1640388998538903220 using(v8);
create or replace view aggView1234263362837682417 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin4234074772449542064 group by v23,v35,v37;
create or replace view aggJoin1670033719696546027 as select v36 as v36, v37, v35 from aggJoin3802871697506945219 join aggView1234263362837682417 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1670033719696546027;
