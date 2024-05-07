create or replace view aggView8670038845842654301 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8822418269844837428 as select movie_id as v12 from movie_keyword as mk, aggView8670038845842654301 where mk.keyword_id=aggView8670038845842654301.v1;
create or replace view aggView3875762175583623585 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin6770436471093848973 as select v12 from aggJoin8822418269844837428 join aggView3875762175583623585 using(v12);
create or replace view aggView5411926065230408544 as select v12 from aggJoin6770436471093848973 group by v12;
create or replace view aggJoin3392632065683016283 as select title as v13, production_year as v16 from title as t, aggView5411926065230408544 where t.id=aggView5411926065230408544.v12 and production_year>2005;
create or replace view aggView8992103285713479484 as select v13 from aggJoin3392632065683016283;
select MIN(v13) as v24 from aggView8992103285713479484;
