create or replace view aggView1077615330737118261 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin4680550385661499552 as select id as v12, title as v13 from title as t, aggView1077615330737118261 where t.id=aggView1077615330737118261.v12 and production_year>1990;
create or replace view aggView8018429770022264169 as select v12, MIN(v13) as v24 from aggJoin4680550385661499552 group by v12;
create or replace view aggJoin5372047015327505895 as select keyword_id as v1, v24 from movie_keyword as mk, aggView8018429770022264169 where mk.movie_id=aggView8018429770022264169.v12;
create or replace view aggView61179134447147193 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7710416333694150377 as select v24 from aggJoin5372047015327505895 join aggView61179134447147193 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin7710416333694150377;
select sum(v24) from res;