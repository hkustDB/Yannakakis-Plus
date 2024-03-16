create or replace view aggView7880712147486513453 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin8735719749933579970 as select id as v12, title as v13 from title as t, aggView7880712147486513453 where t.id=aggView7880712147486513453.v12 and production_year>2005;
create or replace view aggView5296674747020610222 as select v12, MIN(v13) as v24 from aggJoin8735719749933579970 group by v12;
create or replace view aggJoin3765683635922840008 as select keyword_id as v1, v24 from movie_keyword as mk, aggView5296674747020610222 where mk.movie_id=aggView5296674747020610222.v12;
create or replace view aggView7434866165173031084 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6945891354493874833 as select v24 from aggJoin3765683635922840008 join aggView7434866165173031084 using(v1);
select MIN(v24) as v24 from aggJoin6945891354493874833;
