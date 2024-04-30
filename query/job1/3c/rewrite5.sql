create or replace view aggView9109858088689211221 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin1425293692688288111 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView9109858088689211221 where mk.movie_id=aggView9109858088689211221.v12;
create or replace view aggView1320294157501278975 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin5451374825657262737 as select v1, v24 as v24 from aggJoin1425293692688288111 join aggView1320294157501278975 using(v12);
create or replace view aggView4290101377305670074 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6715425052230359475 as select v24 from aggJoin5451374825657262737 join aggView4290101377305670074 using(v1);
select MIN(v24) as v24 from aggJoin6715425052230359475;
