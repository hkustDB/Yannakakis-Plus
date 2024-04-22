create or replace view aggJoin5601510911420132776 as (
with aggView7186246272857029368 as (select id as v12, title as v24 from title as t where production_year>2010)
select movie_id as v12, info as v7, v24 from movie_info as mi, aggView7186246272857029368 where mi.movie_id=aggView7186246272857029368.v12 and info= 'Bulgaria');
create or replace view aggJoin8576922972588998871 as (
with aggView984426355538781371 as (select v12, MIN(v24) as v24 from aggJoin5601510911420132776 group by v12,v24)
select keyword_id as v1, v24 from movie_keyword as mk, aggView984426355538781371 where mk.movie_id=aggView984426355538781371.v12);
create or replace view aggJoin3905464781930638486 as (
with aggView7926403561433941156 as (select id as v1 from keyword as k where keyword LIKE '%sequel%')
select v24 from aggJoin8576922972588998871 join aggView7926403561433941156 using(v1));
select MIN(v24) as v24 from aggJoin3905464781930638486;
