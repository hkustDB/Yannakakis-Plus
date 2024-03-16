create or replace view aggView7371804607774963122 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin1096665776035270272 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView7371804607774963122 where mk.movie_id=aggView7371804607774963122.v12;
create or replace view aggView5114006922623621497 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin2911773473241675233 as select v1, v24 as v24 from aggJoin1096665776035270272 join aggView5114006922623621497 using(v12);
create or replace view aggView2049243317604731477 as select v1, MIN(v24) as v24 from aggJoin2911773473241675233 group by v1;
create or replace view aggJoin8283047842521812679 as select keyword as v2, v24 from keyword as k, aggView2049243317604731477 where k.id=aggView2049243317604731477.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin8283047842521812679;
select sum(v24) from res;