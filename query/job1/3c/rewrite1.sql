create or replace view aggView5592142099833582650 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin2494408871722807678 as select id as v12, title as v13 from title as t, aggView5592142099833582650 where t.id=aggView5592142099833582650.v12 and production_year>1990;
create or replace view aggView6434277789137160377 as select v12, MIN(v13) as v24 from aggJoin2494408871722807678 group by v12;
create or replace view aggJoin9013405110826355095 as select keyword_id as v1, v24 from movie_keyword as mk, aggView6434277789137160377 where mk.movie_id=aggView6434277789137160377.v12;
create or replace view aggView3911025365288295474 as select v1, MIN(v24) as v24 from aggJoin9013405110826355095 group by v1;
create or replace view aggJoin2071745276429514104 as select v24 from keyword as k, aggView3911025365288295474 where k.id=aggView3911025365288295474.v1 and keyword LIKE '%sequel%';
select MIN(v24) as v24 from aggJoin2071745276429514104;
