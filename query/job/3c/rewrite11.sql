create or replace view aggView8470834382949246791 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin5284167442025136913 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView8470834382949246791 where mk.movie_id=aggView8470834382949246791.v12;
create or replace view aggView3387317025569149693 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin6366499511994562462 as select v1, v24 as v24 from aggJoin5284167442025136913 join aggView3387317025569149693 using(v12);
create or replace view aggView7061335769103979080 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6965511987498079687 as select v24 from aggJoin6366499511994562462 join aggView7061335769103979080 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin6965511987498079687;
select sum(v24) from res;