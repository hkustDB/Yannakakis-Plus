create or replace view aggView6763413371384180522 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin6138284849599681236 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView6763413371384180522 where mk.movie_id=aggView6763413371384180522.v12;
create or replace view aggView3819543569510285997 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3383282298751143113 as select v12 from aggJoin6138284849599681236 join aggView3819543569510285997 using(v1);
create or replace view aggView1143148111274802593 as select v12 from aggJoin3383282298751143113 group by v12;
create or replace view aggJoin4714049907900740979 as select title as v13 from title as t, aggView1143148111274802593 where t.id=aggView1143148111274802593.v12 and production_year>2005;
create or replace view res as select MIN(v13) as v24 from aggJoin4714049907900740979;
select sum(v24) from res;