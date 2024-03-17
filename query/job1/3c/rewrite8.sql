create or replace view aggView2159266662143312670 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin6163373824409380851 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView2159266662143312670 where mk.movie_id=aggView2159266662143312670.v12;
create or replace view aggView1223837576672839982 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4941586462641250344 as select v12 from aggJoin6163373824409380851 join aggView1223837576672839982 using(v1);
create or replace view aggView993442061329821617 as select v12 from aggJoin4941586462641250344 group by v12;
create or replace view aggJoin2468458745329779897 as select title as v13 from title as t, aggView993442061329821617 where t.id=aggView993442061329821617.v12 and production_year>1990;
create or replace view res as select MIN(v13) as v24 from aggJoin2468458745329779897;
select sum(v24) from res;