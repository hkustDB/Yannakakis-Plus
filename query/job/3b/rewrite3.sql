create or replace view aggView1712956718546591933 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin6663910144555400424 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView1712956718546591933 where mi.movie_id=aggView1712956718546591933.v12 and info= 'Bulgaria';
create or replace view aggView8827717164588950211 as select v12, MIN(v24) as v24 from aggJoin6663910144555400424 group by v12;
create or replace view aggJoin9056718452008685297 as select keyword_id as v1, v24 from movie_keyword as mk, aggView8827717164588950211 where mk.movie_id=aggView8827717164588950211.v12;
create or replace view aggView6314983744995851700 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5083556844215042135 as select v24 from aggJoin9056718452008685297 join aggView6314983744995851700 using(v1);
select MIN(v24) as v24 from aggJoin5083556844215042135;
