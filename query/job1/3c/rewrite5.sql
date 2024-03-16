create or replace view aggView2128769202983964547 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin6772167772055777917 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView2128769202983964547 where mk.movie_id=aggView2128769202983964547.v12;
create or replace view aggView1352589313424950572 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1425745630782858426 as select v12, v24 from aggJoin6772167772055777917 join aggView1352589313424950572 using(v1);
create or replace view aggView5138700460800768443 as select v12, MIN(v24) as v24 from aggJoin1425745630782858426 group by v12;
create or replace view aggJoin7411957757000649549 as select info as v7, v24 from movie_info as mi, aggView5138700460800768443 where mi.movie_id=aggView5138700460800768443.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view res as select MIN(v24) as v24 from aggJoin7411957757000649549;
select sum(v24) from res;