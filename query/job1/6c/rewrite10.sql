create or replace view aggView17527879223900446 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7601399175195059329 as select movie_id as v23, v35 from movie_keyword as mk, aggView17527879223900446 where mk.keyword_id=aggView17527879223900446.v8;
create or replace view aggView32640116208206413 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2307773932178293939 as select movie_id as v23, v36 from cast_info as ci, aggView32640116208206413 where ci.person_id=aggView32640116208206413.v14;
create or replace view aggView1585271702070558813 as select v23, MIN(v35) as v35 from aggJoin7601399175195059329 group by v23;
create or replace view aggJoin1318792688179848041 as select id as v23, title as v24, v35 from title as t, aggView1585271702070558813 where t.id=aggView1585271702070558813.v23 and production_year>2014;
create or replace view aggView734553708608148503 as select v23, MIN(v36) as v36 from aggJoin2307773932178293939 group by v23;
create or replace view aggJoin8067604426716528131 as select v24, v35 as v35, v36 from aggJoin1318792688179848041 join aggView734553708608148503 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin8067604426716528131;
