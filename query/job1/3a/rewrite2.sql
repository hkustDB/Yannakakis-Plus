create or replace view aggView8529239168332101558 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1271826940881364120 as select movie_id as v12 from movie_keyword as mk, aggView8529239168332101558 where mk.keyword_id=aggView8529239168332101558.v1;
create or replace view aggView363573501344907908 as select v12 from aggJoin1271826940881364120 group by v12;
create or replace view aggJoin7970144533648076723 as select movie_id as v12, info as v7 from movie_info as mi, aggView363573501344907908 where mi.movie_id=aggView363573501344907908.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView4576652897151052866 as select v12 from aggJoin7970144533648076723 group by v12;
create or replace view aggJoin1911488662608664512 as select title as v13 from title as t, aggView4576652897151052866 where t.id=aggView4576652897151052866.v12 and production_year>2005;
create or replace view res as select MIN(v13) as v24 from aggJoin1911488662608664512;
select sum(v24) from res;