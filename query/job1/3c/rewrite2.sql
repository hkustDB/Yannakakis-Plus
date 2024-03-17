create or replace view aggView6893868645561632837 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin7652012833944633995 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView6893868645561632837 where mi.movie_id=aggView6893868645561632837.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView1632508796730922336 as select v12, MIN(v24) as v24 from aggJoin7652012833944633995 group by v12;
create or replace view aggJoin6686152966293849951 as select keyword_id as v1, v24 from movie_keyword as mk, aggView1632508796730922336 where mk.movie_id=aggView1632508796730922336.v12;
create or replace view aggView8304254365798700658 as select v1, MIN(v24) as v24 from aggJoin6686152966293849951 group by v1;
create or replace view aggJoin7606520251248241576 as select keyword as v2, v24 from keyword as k, aggView8304254365798700658 where k.id=aggView8304254365798700658.v1 and keyword LIKE '%sequel%';
select MIN(v24) as v24 from aggJoin7606520251248241576;
