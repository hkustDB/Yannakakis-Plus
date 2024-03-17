create or replace view aggView8705502274946861829 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin5587646219874022895 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView8705502274946861829 where mi.movie_id=aggView8705502274946861829.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView181700662298956660 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5991680673306147116 as select movie_id as v12 from movie_keyword as mk, aggView181700662298956660 where mk.keyword_id=aggView181700662298956660.v1;
create or replace view aggView3084952111551688059 as select v12 from aggJoin5991680673306147116 group by v12;
create or replace view aggJoin6325106110016567134 as select v7, v24 as v24 from aggJoin5587646219874022895 join aggView3084952111551688059 using(v12);
select MIN(v24) as v24 from aggJoin6325106110016567134;
