create or replace view aggView8717943462721796514 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin4606823975359556884 as select id as v12, title as v13 from title as t, aggView8717943462721796514 where t.id=aggView8717943462721796514.v12 and production_year>1990;
create or replace view aggView8949852580851794106 as select v12, MIN(v13) as v24 from aggJoin4606823975359556884 group by v12;
create or replace view aggJoin1565548814189629629 as select keyword_id as v1, v24 from movie_keyword as mk, aggView8949852580851794106 where mk.movie_id=aggView8949852580851794106.v12;
create or replace view aggView5850419318582595289 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1399782067061054841 as select v24 from aggJoin1565548814189629629 join aggView5850419318582595289 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin1399782067061054841;
select sum(v24) from res;