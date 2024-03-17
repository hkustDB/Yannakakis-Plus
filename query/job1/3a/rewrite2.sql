create or replace view aggView1418150857463551084 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin4480411140664026065 as select id as v12, title as v13 from title as t, aggView1418150857463551084 where t.id=aggView1418150857463551084.v12 and production_year>2005;
create or replace view aggView6191656756447169526 as select v12, MIN(v13) as v24 from aggJoin4480411140664026065 group by v12;
create or replace view aggJoin3788203651496902080 as select keyword_id as v1, v24 from movie_keyword as mk, aggView6191656756447169526 where mk.movie_id=aggView6191656756447169526.v12;
create or replace view aggView8875273725544670189 as select v1, MIN(v24) as v24 from aggJoin3788203651496902080 group by v1;
create or replace view aggJoin8872916258578195447 as select v24 from keyword as k, aggView8875273725544670189 where k.id=aggView8875273725544670189.v1 and keyword LIKE '%sequel%';
select MIN(v24) as v24 from aggJoin8872916258578195447;
