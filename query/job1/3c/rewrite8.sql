create or replace view aggView9025051994321510861 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2297212599638040513 as select movie_id as v12 from movie_keyword as mk, aggView9025051994321510861 where mk.keyword_id=aggView9025051994321510861.v1;
create or replace view aggView1957489394002435094 as select v12 from aggJoin2297212599638040513 group by v12;
create or replace view aggJoin8957083195657790830 as select id as v12, title as v13 from title as t, aggView1957489394002435094 where t.id=aggView1957489394002435094.v12 and production_year>1990;
create or replace view aggView5642123613696628855 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin3526253488849308297 as select v13 from aggJoin8957083195657790830 join aggView5642123613696628855 using(v12);
create or replace view res as select MIN(v13) as v24 from aggJoin3526253488849308297;
select sum(v24) from res;