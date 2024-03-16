create or replace view aggView7904212234090635338 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin145450638778294328 as select movie_id as v23, v35 from movie_keyword as mk, aggView7904212234090635338 where mk.keyword_id=aggView7904212234090635338.v8;
create or replace view aggView455420185596829282 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1066362071735628441 as select movie_id as v23, v36 from cast_info as ci, aggView455420185596829282 where ci.person_id=aggView455420185596829282.v14;
create or replace view aggView7459665511757553282 as select v23, MIN(v35) as v35 from aggJoin145450638778294328 group by v23;
create or replace view aggJoin5454533244221388266 as select v23, v36 as v36, v35 from aggJoin1066362071735628441 join aggView7459665511757553282 using(v23);
create or replace view aggView940207217093549447 as select v23, MIN(v36) as v36, MIN(v35) as v35 from aggJoin5454533244221388266 group by v23;
create or replace view aggJoin5624086883486467735 as select title as v24, v36, v35 from title as t, aggView940207217093549447 where t.id=aggView940207217093549447.v23 and production_year>2010;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin5624086883486467735;
