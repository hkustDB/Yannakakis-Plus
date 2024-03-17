create or replace view aggView1651388552841521992 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2345027614221110031 as select movie_id as v23, v36 from cast_info as ci, aggView1651388552841521992 where ci.person_id=aggView1651388552841521992.v14;
create or replace view aggView5424227225004787769 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin6610482394760037314 as select movie_id as v23, v35 from movie_keyword as mk, aggView5424227225004787769 where mk.keyword_id=aggView5424227225004787769.v8;
create or replace view aggView7409795039691114974 as select v23, MIN(v36) as v36 from aggJoin2345027614221110031 group by v23;
create or replace view aggJoin4264265466529790281 as select id as v23, title as v24, v36 from title as t, aggView7409795039691114974 where t.id=aggView7409795039691114974.v23 and production_year>2014;
create or replace view aggView6296013393957748276 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin4264265466529790281 group by v23;
create or replace view aggJoin1112540960944040084 as select v35 as v35, v36, v37 from aggJoin6610482394760037314 join aggView6296013393957748276 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1112540960944040084;
