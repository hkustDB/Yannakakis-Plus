create or replace view aggView4464466921834631665 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin8909881422201439133 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView4464466921834631665 where mk.movie_id=aggView4464466921834631665.v12;
create or replace view aggView5784313539219028638 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8715488099137689983 as select v12, v24 from aggJoin8909881422201439133 join aggView5784313539219028638 using(v1);
create or replace view aggView370147991156690232 as select v12, MIN(v24) as v24 from aggJoin8715488099137689983 group by v12;
create or replace view aggJoin5354388867149642921 as select info as v7, v24 from movie_info as mi, aggView370147991156690232 where mi.movie_id=aggView370147991156690232.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view res as select MIN(v24) as v24 from aggJoin5354388867149642921;
select sum(v24) from res;