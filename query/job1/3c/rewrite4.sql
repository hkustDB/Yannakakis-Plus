create or replace view aggView7709706263715756835 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin3598785149992330398 as select id as v12, title as v13 from title as t, aggView7709706263715756835 where t.id=aggView7709706263715756835.v12 and production_year>1990;
create or replace view aggView7273337326511164899 as select v12, MIN(v13) as v24 from aggJoin3598785149992330398 group by v12;
create or replace view aggJoin8747462396850313292 as select keyword_id as v1, v24 from movie_keyword as mk, aggView7273337326511164899 where mk.movie_id=aggView7273337326511164899.v12;
create or replace view aggView7812949777681725017 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5553863198434878993 as select v24 from aggJoin8747462396850313292 join aggView7812949777681725017 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin5553863198434878993;
select sum(v24) from res;