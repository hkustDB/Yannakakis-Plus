create or replace view aggView4792393549707294591 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8974119825435951700 as select movie_id as v12 from movie_keyword as mk, aggView4792393549707294591 where mk.keyword_id=aggView4792393549707294591.v1;
create or replace view aggView4927934409403117955 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin8443734225635856839 as select id as v12, title as v13, production_year as v16 from title as t, aggView4927934409403117955 where t.id=aggView4927934409403117955.v12 and production_year>1990;
create or replace view aggView2530270254712557153 as select v12 from aggJoin8974119825435951700 group by v12;
create or replace view aggJoin4343938382687912676 as select v13, v16 from aggJoin8443734225635856839 join aggView2530270254712557153 using(v12);
create or replace view aggView9102835636036404794 as select v13 from aggJoin4343938382687912676;
select MIN(v13) as v24 from aggView9102835636036404794;
