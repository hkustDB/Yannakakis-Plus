create or replace view aggView2326269143414314927 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin1782774556385679931 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView2326269143414314927 where mk.movie_id=aggView2326269143414314927.v12;
create or replace view aggView4030274742960998473 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5480980700045563368 as select v12, v24 from aggJoin1782774556385679931 join aggView4030274742960998473 using(v1);
create or replace view aggView2278829188055083992 as select v12, MIN(v24) as v24 from aggJoin5480980700045563368 group by v12;
create or replace view aggJoin3873509519048635695 as select info as v7, v24 from movie_info as mi, aggView2278829188055083992 where mi.movie_id=aggView2278829188055083992.v12 and info= 'Bulgaria';
create or replace view res as select MIN(v24) as v24 from aggJoin3873509519048635695;
select sum(v24) from res;