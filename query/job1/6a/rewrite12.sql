create or replace view aggView5944057758740832882 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin1397616366475542758 as select movie_id as v23, v35 from movie_keyword as mk, aggView5944057758740832882 where mk.keyword_id=aggView5944057758740832882.v8;
create or replace view aggView1244660000079547430 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin5653599070784083146 as select movie_id as v23, v36 from cast_info as ci, aggView1244660000079547430 where ci.person_id=aggView1244660000079547430.v14;
create or replace view aggView226947938204804681 as select v23, MIN(v35) as v35 from aggJoin1397616366475542758 group by v23;
create or replace view aggJoin6043938690357113475 as select id as v23, title as v24, v35 from title as t, aggView226947938204804681 where t.id=aggView226947938204804681.v23 and production_year>2010;
create or replace view aggView4081102149891322612 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin6043938690357113475 group by v23;
create or replace view aggJoin2361312584403489751 as select v36 as v36, v35, v37 from aggJoin5653599070784083146 join aggView4081102149891322612 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin2361312584403489751;
