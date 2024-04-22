create or replace view aggJoin8572861979173395153 as (
with aggView3462328781941655283 as (select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id)
select id as v12, title as v13, production_year as v16 from title as t, aggView3462328781941655283 where t.id=aggView3462328781941655283.v12 and production_year>2010);
create or replace view aggJoin8391783481539831813 as (
with aggView789707299124552218 as (select v12, MIN(v13) as v24 from aggJoin8572861979173395153 group by v12)
select keyword_id as v1, v24 from movie_keyword as mk, aggView789707299124552218 where mk.movie_id=aggView789707299124552218.v12);
create or replace view aggJoin2319067152498907228 as (
with aggView9191948446659140462 as (select id as v1 from keyword as k where keyword LIKE '%sequel%')
select v24 from aggJoin8391783481539831813 join aggView9191948446659140462 using(v1));
select MIN(v24) as v24 from aggJoin2319067152498907228;
