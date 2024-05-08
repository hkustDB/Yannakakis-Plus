create or replace view aggView1349891446852479399 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5688228253953404270 as select movie_id as v12 from movie_keyword as mk, aggView1349891446852479399 where mk.keyword_id=aggView1349891446852479399.v1;
create or replace view aggView5492991657718209359 as select v12 from aggJoin5688228253953404270 group by v12;
create or replace view aggJoin8828592594786319905 as select movie_id as v12, info as v7 from movie_info as mi, aggView5492991657718209359 where mi.movie_id=aggView5492991657718209359.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView8933181401217466262 as select v12 from aggJoin8828592594786319905 group by v12;
create or replace view aggJoin1864067897324135098 as select title as v13, production_year as v16 from title as t, aggView8933181401217466262 where t.id=aggView8933181401217466262.v12 and production_year>1990;
create or replace view aggView4582281925031236223 as select v13 from aggJoin1864067897324135098;
select MIN(v13) as v24 from aggView4582281925031236223;
