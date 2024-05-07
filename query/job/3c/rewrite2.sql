create or replace view aggView6254661132469906565 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1585242839095392454 as select movie_id as v12 from movie_keyword as mk, aggView6254661132469906565 where mk.keyword_id=aggView6254661132469906565.v1;
create or replace view aggView1205535392088245113 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin8137679307595935921 as select v12 from aggJoin1585242839095392454 join aggView1205535392088245113 using(v12);
create or replace view aggView8737387937885253309 as select v12 from aggJoin8137679307595935921 group by v12;
create or replace view aggJoin8777069353240354652 as select title as v13, production_year as v16 from title as t, aggView8737387937885253309 where t.id=aggView8737387937885253309.v12 and production_year>1990;
create or replace view aggView5052630180604630852 as select v13 from aggJoin8777069353240354652;
select MIN(v13) as v24 from aggView5052630180604630852;
