create or replace view aggView218197822586929003 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin6769704022341366380 as select id as v12, title as v13 from title as t, aggView218197822586929003 where t.id=aggView218197822586929003.v12 and production_year>2005;
create or replace view aggView1348839969997618647 as select v12, MIN(v13) as v24 from aggJoin6769704022341366380 group by v12;
create or replace view aggJoin8519122480106187072 as select keyword_id as v1, v24 from movie_keyword as mk, aggView1348839969997618647 where mk.movie_id=aggView1348839969997618647.v12;
create or replace view aggView2619448203225848008 as select v1, MIN(v24) as v24 from aggJoin8519122480106187072 group by v1;
create or replace view aggJoin5592272741738389410 as select v24 from keyword as k, aggView2619448203225848008 where k.id=aggView2619448203225848008.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin5592272741738389410;
select sum(v24) from res;