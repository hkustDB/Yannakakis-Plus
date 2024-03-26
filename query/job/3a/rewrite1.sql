create or replace view aggView1301991989124764098 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin8186134659751629109 as select id as v12, title as v13 from title as t, aggView1301991989124764098 where t.id=aggView1301991989124764098.v12 and production_year>2005;
create or replace view aggView22160282860016648 as select v12, MIN(v13) as v24 from aggJoin8186134659751629109 group by v12;
create or replace view aggJoin8099344040086099183 as select keyword_id as v1, v24 from movie_keyword as mk, aggView22160282860016648 where mk.movie_id=aggView22160282860016648.v12;
create or replace view aggView1387717901737369300 as select v1, MIN(v24) as v24 from aggJoin8099344040086099183 group by v1;
create or replace view aggJoin6993838159464638060 as select v24 from keyword as k, aggView1387717901737369300 where k.id=aggView1387717901737369300.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin6993838159464638060;
select sum(v24) from res;