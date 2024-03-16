create or replace view aggView4669058484159347965 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin8192274188354786170 as select id as v12, title as v13 from title as t, aggView4669058484159347965 where t.id=aggView4669058484159347965.v12 and production_year>2010;
create or replace view aggView1022310009018733376 as select v12, MIN(v13) as v24 from aggJoin8192274188354786170 group by v12;
create or replace view aggJoin6876399851709848109 as select keyword_id as v1, v24 from movie_keyword as mk, aggView1022310009018733376 where mk.movie_id=aggView1022310009018733376.v12;
create or replace view aggView1703209360374631325 as select v1, MIN(v24) as v24 from aggJoin6876399851709848109 group by v1;
create or replace view aggJoin1510141244356725570 as select v24 from keyword as k, aggView1703209360374631325 where k.id=aggView1703209360374631325.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin1510141244356725570;
select sum(v24) from res;