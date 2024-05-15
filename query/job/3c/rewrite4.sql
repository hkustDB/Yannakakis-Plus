create or replace view aggView6863331650323481111 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin8237933562545891690 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView6863331650323481111 where mi.movie_id=aggView6863331650323481111.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView4366890636085553312 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin9210275325226094473 as select movie_id as v12 from movie_keyword as mk, aggView4366890636085553312 where mk.keyword_id=aggView4366890636085553312.v1;
create or replace view aggView4995030552438086130 as select v12, MIN(v24) as v24 from aggJoin8237933562545891690 group by v12;
create or replace view aggJoin4677814937447821029 as select v24 from aggJoin9210275325226094473 join aggView4995030552438086130 using(v12);
select MIN(v24) as v24 from aggJoin4677814937447821029;
