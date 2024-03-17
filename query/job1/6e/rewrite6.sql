create or replace view aggView1813588916225934051 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1962277999707941590 as select movie_id as v23, v36 from cast_info as ci, aggView1813588916225934051 where ci.person_id=aggView1813588916225934051.v14;
create or replace view aggView5963427851830754553 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin2143194535301903751 as select movie_id as v23, v35 from movie_keyword as mk, aggView5963427851830754553 where mk.keyword_id=aggView5963427851830754553.v8;
create or replace view aggView1713866094786644885 as select v23, MIN(v36) as v36 from aggJoin1962277999707941590 group by v23;
create or replace view aggJoin6118797287827813313 as select id as v23, title as v24, v36 from title as t, aggView1713866094786644885 where t.id=aggView1713866094786644885.v23 and production_year>2000;
create or replace view aggView807747618324751663 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin6118797287827813313 group by v23;
create or replace view aggJoin314665187563526431 as select v35 as v35, v36, v37 from aggJoin2143194535301903751 join aggView807747618324751663 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin314665187563526431;
