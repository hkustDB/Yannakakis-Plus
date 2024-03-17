create or replace view aggView9175034020095682419 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin7247888416292510573 as select id as v12, title as v13 from title as t, aggView9175034020095682419 where t.id=aggView9175034020095682419.v12 and production_year>1990;
create or replace view aggView3715647412497032115 as select v12, MIN(v13) as v24 from aggJoin7247888416292510573 group by v12;
create or replace view aggJoin6842812420450457506 as select keyword_id as v1, v24 from movie_keyword as mk, aggView3715647412497032115 where mk.movie_id=aggView3715647412497032115.v12;
create or replace view aggView8603077756163842626 as select v1, MIN(v24) as v24 from aggJoin6842812420450457506 group by v1;
create or replace view aggJoin7152244383321354334 as select v24 from keyword as k, aggView8603077756163842626 where k.id=aggView8603077756163842626.v1 and keyword LIKE '%sequel%';
select MIN(v24) as v24 from aggJoin7152244383321354334;
