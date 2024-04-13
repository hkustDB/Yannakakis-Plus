create or replace view aggView7064685864473756603 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7671031495669073038 as select movie_id as v23, v35 from movie_keyword as mk, aggView7064685864473756603 where mk.keyword_id=aggView7064685864473756603.v8;
create or replace view aggView982027302376981658 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8768782548865781276 as select movie_id as v23, v36 from cast_info as ci, aggView982027302376981658 where ci.person_id=aggView982027302376981658.v14;
create or replace view aggView4824964605789922018 as select v23, MIN(v35) as v35 from aggJoin7671031495669073038 group by v23,v35;
create or replace view aggJoin5641672976677001992 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView4824964605789922018 where t.id=aggView4824964605789922018.v23 and production_year>2000;
create or replace view aggView971598559939694336 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin5641672976677001992 group by v23,v35;
create or replace view aggJoin840450259720219904 as select v36 as v36, v35, v37 from aggJoin8768782548865781276 join aggView971598559939694336 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin840450259720219904;
