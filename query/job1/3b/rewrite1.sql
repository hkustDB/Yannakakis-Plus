create or replace view aggView8904484561799398508 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6999815976131859606 as select movie_id as v12 from movie_keyword as mk, aggView8904484561799398508 where mk.keyword_id=aggView8904484561799398508.v1;
create or replace view aggView6038931966342974824 as select v12 from aggJoin6999815976131859606 group by v12;
create or replace view aggJoin577453212042578835 as select id as v12, title as v13 from title as t, aggView6038931966342974824 where t.id=aggView6038931966342974824.v12 and production_year>2010;
create or replace view aggView4665573828462393366 as select v12, MIN(v13) as v24 from aggJoin577453212042578835 group by v12;
create or replace view aggJoin935434234616070664 as select v24 from movie_info as mi, aggView4665573828462393366 where mi.movie_id=aggView4665573828462393366.v12 and info= 'Bulgaria';
create or replace view res as select MIN(v24) as v24 from aggJoin935434234616070664;
select sum(v24) from res;