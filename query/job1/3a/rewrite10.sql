create or replace view aggView5975746246490940734 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin6106592494563270232 as select id as v12, title as v13 from title as t, aggView5975746246490940734 where t.id=aggView5975746246490940734.v12 and production_year>2005;
create or replace view aggView6739948423715328702 as select v12, MIN(v13) as v24 from aggJoin6106592494563270232 group by v12;
create or replace view aggJoin6356488731121126010 as select keyword_id as v1, v24 from movie_keyword as mk, aggView6739948423715328702 where mk.movie_id=aggView6739948423715328702.v12;
create or replace view aggView1814574159668381303 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1637235041473140910 as select v24 from aggJoin6356488731121126010 join aggView1814574159668381303 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin1637235041473140910;
select sum(v24) from res;