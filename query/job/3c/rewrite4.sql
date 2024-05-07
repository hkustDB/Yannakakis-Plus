create or replace view aggView2740049222178614279 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin4401880722842819264 as select id as v12, title as v13, production_year as v16 from title as t, aggView2740049222178614279 where t.id=aggView2740049222178614279.v12 and production_year>1990;
create or replace view aggView4086477148584899141 as select v12, MIN(v13) as v24 from aggJoin4401880722842819264 group by v12;
create or replace view aggJoin8926997239433091540 as select keyword_id as v1, v24 from movie_keyword as mk, aggView4086477148584899141 where mk.movie_id=aggView4086477148584899141.v12;
create or replace view aggView8747320192953278432 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8177992008390820094 as select v24 from aggJoin8926997239433091540 join aggView8747320192953278432 using(v1);
select MIN(v24) as v24 from aggJoin8177992008390820094;
