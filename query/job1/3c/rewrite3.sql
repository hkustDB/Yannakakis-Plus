create or replace view aggView6072977753565584137 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3178112954624019435 as select movie_id as v12 from movie_keyword as mk, aggView6072977753565584137 where mk.keyword_id=aggView6072977753565584137.v1;
create or replace view aggView955136192484628338 as select v12 from aggJoin3178112954624019435 group by v12;
create or replace view aggJoin7405925969292736191 as select movie_id as v12, info as v7 from movie_info as mi, aggView955136192484628338 where mi.movie_id=aggView955136192484628338.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView3858745209075648139 as select v12 from aggJoin7405925969292736191 group by v12;
create or replace view aggJoin3166116394747390083 as select title as v13 from title as t, aggView3858745209075648139 where t.id=aggView3858745209075648139.v12 and production_year>1990;
select MIN(v13) as v24 from aggJoin3166116394747390083;
