create or replace view aggView1064408811075366938 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8137088724575507703 as select movie_id as v12 from movie_keyword as mk, aggView1064408811075366938 where mk.keyword_id=aggView1064408811075366938.v1;
create or replace view aggView5038099777232852832 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin1228185869735117890 as select id as v12, title as v13, production_year as v16 from title as t, aggView5038099777232852832 where t.id=aggView5038099777232852832.v12 and production_year>1990;
create or replace view aggView4940363922911700832 as select v12 from aggJoin8137088724575507703 group by v12;
create or replace view aggJoin6406663506453688161 as select v13, v16 from aggJoin1228185869735117890 join aggView4940363922911700832 using(v12);
create or replace view aggView5356143485728321201 as select v13 from aggJoin6406663506453688161;
select MIN(v13) as v24 from aggView5356143485728321201;
