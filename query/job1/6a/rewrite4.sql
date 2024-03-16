create or replace view aggView6726383859636179027 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin2456804515189580857 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView6726383859636179027 where mk.movie_id=aggView6726383859636179027.v23;
create or replace view aggView1389078867716944790 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4101102018375784237 as select v23, v37 from aggJoin2456804515189580857 join aggView1389078867716944790 using(v8);
create or replace view aggView1789009614809621489 as select v23, MIN(v37) as v37 from aggJoin4101102018375784237 group by v23;
create or replace view aggJoin251359390917836562 as select person_id as v14, v37 from cast_info as ci, aggView1789009614809621489 where ci.movie_id=aggView1789009614809621489.v23;
create or replace view aggView7876165256887764529 as select v14, MIN(v37) as v37 from aggJoin251359390917836562 group by v14;
create or replace view aggJoin8192241951451426655 as select name as v15, v37 from name as n, aggView7876165256887764529 where n.id=aggView7876165256887764529.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin8192241951451426655;
