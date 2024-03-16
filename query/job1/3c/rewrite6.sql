create or replace view aggView2897970081215003434 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin4341264920168979221 as select id as v12, title as v13 from title as t, aggView2897970081215003434 where t.id=aggView2897970081215003434.v12 and production_year>1990;
create or replace view aggView3356060552269877776 as select v12, MIN(v13) as v24 from aggJoin4341264920168979221 group by v12;
create or replace view aggJoin4548452015910045545 as select keyword_id as v1, v24 from movie_keyword as mk, aggView3356060552269877776 where mk.movie_id=aggView3356060552269877776.v12;
create or replace view aggView7408296869475366295 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7632301577256430086 as select v24 from aggJoin4548452015910045545 join aggView7408296869475366295 using(v1);
select MIN(v24) as v24 from aggJoin7632301577256430086;
