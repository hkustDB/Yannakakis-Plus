create or replace view aggView8795408674208557299 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin7133906046977919406 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView8795408674208557299 where mi.movie_id=aggView8795408674208557299.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView1141596680597641168 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1626163270294587596 as select movie_id as v12 from movie_keyword as mk, aggView1141596680597641168 where mk.keyword_id=aggView1141596680597641168.v1;
create or replace view aggView4665166540382099903 as select v12 from aggJoin1626163270294587596 group by v12;
create or replace view aggJoin8602862654716822370 as select v7, v24 as v24 from aggJoin7133906046977919406 join aggView4665166540382099903 using(v12);
select MIN(v24) as v24 from aggJoin8602862654716822370;
