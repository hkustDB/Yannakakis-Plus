create or replace view aggView4304638938156886888 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin8676621108341316746 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView4304638938156886888 where mi.movie_id=aggView4304638938156886888.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView2697855365373539061 as select v12, MIN(v24) as v24 from aggJoin8676621108341316746 group by v12;
create or replace view aggJoin1901637691888833189 as select keyword_id as v1, v24 from movie_keyword as mk, aggView2697855365373539061 where mk.movie_id=aggView2697855365373539061.v12;
create or replace view aggView6661547517022729469 as select v1, MIN(v24) as v24 from aggJoin1901637691888833189 group by v1;
create or replace view aggJoin4318801749816279533 as select keyword as v2, v24 from keyword as k, aggView6661547517022729469 where k.id=aggView6661547517022729469.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin4318801749816279533;
select sum(v24) from res;