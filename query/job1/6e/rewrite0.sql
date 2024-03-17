create or replace view aggView5294046787032542626 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8184908834599571642 as select movie_id as v23, v36 from cast_info as ci, aggView5294046787032542626 where ci.person_id=aggView5294046787032542626.v14;
create or replace view aggView8191029606902131803 as select v23, MIN(v36) as v36 from aggJoin8184908834599571642 group by v23;
create or replace view aggJoin1961304710880963889 as select id as v23, title as v24, v36 from title as t, aggView8191029606902131803 where t.id=aggView8191029606902131803.v23 and production_year>2000;
create or replace view aggView1159286080504769624 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin1961304710880963889 group by v23;
create or replace view aggJoin3992480906937443542 as select keyword_id as v8, v36, v37 from movie_keyword as mk, aggView1159286080504769624 where mk.movie_id=aggView1159286080504769624.v23;
create or replace view aggView7955756099565769184 as select v8, MIN(v36) as v36, MIN(v37) as v37 from aggJoin3992480906937443542 group by v8;
create or replace view aggJoin5071862663311496471 as select keyword as v9, v36, v37 from keyword as k, aggView7955756099565769184 where k.id=aggView7955756099565769184.v8 and keyword= 'marvel-cinematic-universe';
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin5071862663311496471;
