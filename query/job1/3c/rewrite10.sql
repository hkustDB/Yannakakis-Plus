create or replace view aggView8036494769638565226 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin8575198594763238291 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView8036494769638565226 where mk.movie_id=aggView8036494769638565226.v12;
create or replace view aggView2027251222618826570 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin2349232105064926096 as select v1, v24 as v24 from aggJoin8575198594763238291 join aggView2027251222618826570 using(v12);
create or replace view aggView6022216461948994018 as select v1, MIN(v24) as v24 from aggJoin2349232105064926096 group by v1;
create or replace view aggJoin8863228085517105938 as select keyword as v2, v24 from keyword as k, aggView6022216461948994018 where k.id=aggView6022216461948994018.v1 and keyword LIKE '%sequel%';
select MIN(v24) as v24 from aggJoin8863228085517105938;
