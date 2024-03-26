create or replace view aggView4230020641273042050 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin5471675825238229361 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView4230020641273042050 where mk.movie_id=aggView4230020641273042050.v12;
create or replace view aggView2295613664848401080 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin6655974344369247288 as select v1, v24 as v24 from aggJoin5471675825238229361 join aggView2295613664848401080 using(v12);
create or replace view aggView3297072998580174760 as select v1, MIN(v24) as v24 from aggJoin6655974344369247288 group by v1;
create or replace view aggJoin4818288345678832853 as select keyword as v2, v24 from keyword as k, aggView3297072998580174760 where k.id=aggView3297072998580174760.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin4818288345678832853;
select sum(v24) from res;