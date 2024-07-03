create or replace view aggView784359746516195187 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7410973609439555988 as select movie_id as v12 from movie_keyword as mk, aggView784359746516195187 where mk.keyword_id=aggView784359746516195187.v1;
create or replace view aggView7043699566746098334 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin6539692061470049525 as select v12 from aggJoin7410973609439555988 join aggView7043699566746098334 using(v12);
create or replace view aggView2002855315776127649 as select v12 from aggJoin6539692061470049525 group by v12;
create or replace view aggJoin5814038787957587933 as select title as v13, production_year as v16 from title as t, aggView2002855315776127649 where t.id=aggView2002855315776127649.v12 and production_year>1990;
create or replace view aggView8837217978291238836 as select v13 from aggJoin5814038787957587933;
select MIN(v13) as v24 from aggView8837217978291238836;
