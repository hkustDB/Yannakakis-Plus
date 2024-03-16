create or replace view aggView5711309142156889680 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4224323335110160491 as select movie_id as v12 from movie_keyword as mk, aggView5711309142156889680 where mk.keyword_id=aggView5711309142156889680.v1;
create or replace view aggView6802662703078361219 as select v12 from aggJoin4224323335110160491 group by v12;
create or replace view aggJoin3711751060876173755 as select movie_id as v12, info as v7 from movie_info as mi, aggView6802662703078361219 where mi.movie_id=aggView6802662703078361219.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView9106468232780215110 as select v12 from aggJoin3711751060876173755 group by v12;
create or replace view aggJoin3095459160132182329 as select title as v13 from title as t, aggView9106468232780215110 where t.id=aggView9106468232780215110.v12 and production_year>1990;
create or replace view res as select MIN(v13) as v24 from aggJoin3095459160132182329;
select sum(v24) from res;