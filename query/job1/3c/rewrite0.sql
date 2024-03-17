create or replace view aggView8308980341541058944 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin3739467478130208736 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView8308980341541058944 where mi.movie_id=aggView8308980341541058944.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView4820925333716254642 as select v12, MIN(v24) as v24 from aggJoin3739467478130208736 group by v12;
create or replace view aggJoin6598564436051302536 as select keyword_id as v1, v24 from movie_keyword as mk, aggView4820925333716254642 where mk.movie_id=aggView4820925333716254642.v12;
create or replace view aggView4502796277915284845 as select v1, MIN(v24) as v24 from aggJoin6598564436051302536 group by v1;
create or replace view aggJoin757667481754919002 as select keyword as v2, v24 from keyword as k, aggView4502796277915284845 where k.id=aggView4502796277915284845.v1 and keyword LIKE '%sequel%';
select MIN(v24) as v24 from aggJoin757667481754919002;
