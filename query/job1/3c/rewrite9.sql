create or replace view aggView2541843391825582801 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4036494458294110474 as select movie_id as v12 from movie_keyword as mk, aggView2541843391825582801 where mk.keyword_id=aggView2541843391825582801.v1;
create or replace view aggView1047094212752325000 as select v12 from aggJoin4036494458294110474 group by v12;
create or replace view aggJoin2663414914482673443 as select id as v12, title as v13 from title as t, aggView1047094212752325000 where t.id=aggView1047094212752325000.v12 and production_year>1990;
create or replace view aggView6762938408611855685 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin5766753180630454059 as select v13 from aggJoin2663414914482673443 join aggView6762938408611855685 using(v12);
select MIN(v13) as v24 from aggJoin5766753180630454059;
