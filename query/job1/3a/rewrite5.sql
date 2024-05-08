create or replace view aggView4822980659322038551 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin7484131404104413290 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView4822980659322038551 where mk.movie_id=aggView4822980659322038551.v12;
create or replace view aggView1822224397298872362 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin1235328991794504686 as select v1, v24 as v24 from aggJoin7484131404104413290 join aggView1822224397298872362 using(v12);
create or replace view aggView3308162698405647476 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8584477410800393531 as select v24 from aggJoin1235328991794504686 join aggView3308162698405647476 using(v1);
select MIN(v24) as v24 from aggJoin8584477410800393531;
