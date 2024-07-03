create or replace view aggView1757212980675562216 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5133534087674379955 as select movie_id as v12 from movie_keyword as mk, aggView1757212980675562216 where mk.keyword_id=aggView1757212980675562216.v1;
create or replace view aggView8429129851238388499 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin5421637308568720265 as select v12 from aggJoin5133534087674379955 join aggView8429129851238388499 using(v12);
create or replace view aggView8922670949575860947 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin1262813286615483384 as select v24 from aggJoin5421637308568720265 join aggView8922670949575860947 using(v12);
select MIN(v24) as v24 from aggJoin1262813286615483384;
