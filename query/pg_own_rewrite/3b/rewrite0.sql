create or replace view aggView3937330100263160211 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin657188073453208464 as select movie_id as v12 from movie_keyword as mk, aggView3937330100263160211 where mk.keyword_id=aggView3937330100263160211.v1;
create or replace view aggView2904882146240454347 as select v12 from aggJoin657188073453208464 group by v12;
create or replace view aggJoin7028060626068191441 as select movie_id as v12, info as v7 from movie_info as mi, aggView2904882146240454347 where mi.movie_id=aggView2904882146240454347.v12 and info= 'Bulgaria';
create or replace view aggView8989069695280508813 as select v12 from aggJoin7028060626068191441 group by v12;
create or replace view aggJoin7923008827691800529 as select title as v13, production_year as v16 from title as t, aggView8989069695280508813 where t.id=aggView8989069695280508813.v12 and production_year>2010;
create or replace view aggView8747544223369987510 as select v13 from aggJoin7923008827691800529;
select MIN(v13) as v24 from aggView8747544223369987510;
