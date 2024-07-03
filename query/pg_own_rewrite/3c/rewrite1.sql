create or replace view aggView4031333718704142319 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1713119653861371273 as select movie_id as v12 from movie_keyword as mk, aggView4031333718704142319 where mk.keyword_id=aggView4031333718704142319.v1;
create or replace view aggView2043240965800794499 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin5680361222837379992 as select id as v12, title as v13, production_year as v16 from title as t, aggView2043240965800794499 where t.id=aggView2043240965800794499.v12 and production_year>1990;
create or replace view aggView7941001356264640800 as select v12 from aggJoin1713119653861371273 group by v12;
create or replace view aggJoin2729533371174786263 as select v13, v16 from aggJoin5680361222837379992 join aggView7941001356264640800 using(v12);
create or replace view aggView1831302659715088637 as select v13 from aggJoin2729533371174786263;
select MIN(v13) as v24 from aggView1831302659715088637;
