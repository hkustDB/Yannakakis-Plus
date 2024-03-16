create or replace view aggView7188128576015324862 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin472332138558313598 as select movie_id as v23, v36 from cast_info as ci, aggView7188128576015324862 where ci.person_id=aggView7188128576015324862.v14;
create or replace view aggView9125986286852547012 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin1200152878563422479 as select movie_id as v23, v35 from movie_keyword as mk, aggView9125986286852547012 where mk.keyword_id=aggView9125986286852547012.v8;
create or replace view aggView4900119075958758422 as select v23, MIN(v36) as v36 from aggJoin472332138558313598 group by v23;
create or replace view aggJoin4872902485198839698 as select id as v23, title as v24, v36 from title as t, aggView4900119075958758422 where t.id=aggView4900119075958758422.v23 and production_year>2010;
create or replace view aggView2952260207229348941 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin4872902485198839698 group by v23;
create or replace view aggJoin1046348236840281653 as select v35 as v35, v36, v37 from aggJoin1200152878563422479 join aggView2952260207229348941 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1046348236840281653;
