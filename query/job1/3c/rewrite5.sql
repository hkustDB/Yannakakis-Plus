create or replace view aggView7711711747549617161 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7509772660758651633 as select movie_id as v12 from movie_keyword as mk, aggView7711711747549617161 where mk.keyword_id=aggView7711711747549617161.v1;
create or replace view aggView6518172959079475815 as select v12 from aggJoin7509772660758651633 group by v12;
create or replace view aggJoin1927685383586362404 as select id as v12, title as v13 from title as t, aggView6518172959079475815 where t.id=aggView6518172959079475815.v12 and production_year>1990;
create or replace view aggView1946878069662073688 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin3821080421776249309 as select v13 from aggJoin1927685383586362404 join aggView1946878069662073688 using(v12);
create or replace view res as select MIN(v13) as v24 from aggJoin3821080421776249309;
select sum(v24) from res;