create or replace view aggView7663182107051427250 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8185698387650022641 as select movie_id as v23, v36 from cast_info as ci, aggView7663182107051427250 where ci.person_id=aggView7663182107051427250.v14;
create or replace view aggView5127315008265968669 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4185955706614875069 as select movie_id as v23, v35 from movie_keyword as mk, aggView5127315008265968669 where mk.keyword_id=aggView5127315008265968669.v8;
create or replace view aggView3085155232067889388 as select v23, MIN(v35) as v35 from aggJoin4185955706614875069 group by v23;
create or replace view aggJoin1992806612710398299 as select id as v23, title as v24, v35 from title as t, aggView3085155232067889388 where t.id=aggView3085155232067889388.v23 and production_year>2014;
create or replace view aggView3114235915810964893 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin1992806612710398299 group by v23;
create or replace view aggJoin6129470863628999547 as select v36 as v36, v35, v37 from aggJoin8185698387650022641 join aggView3114235915810964893 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin6129470863628999547;
