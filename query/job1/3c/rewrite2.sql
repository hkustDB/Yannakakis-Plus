create or replace view aggView104238721793584681 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8271028697202983036 as select movie_id as v12 from movie_keyword as mk, aggView104238721793584681 where mk.keyword_id=aggView104238721793584681.v1;
create or replace view aggView3048441069018867502 as select v12 from aggJoin8271028697202983036 group by v12;
create or replace view aggJoin7291648760856714345 as select id as v12, title as v13 from title as t, aggView3048441069018867502 where t.id=aggView3048441069018867502.v12 and production_year>1990;
create or replace view aggView6862838015717835558 as select v12, MIN(v13) as v24 from aggJoin7291648760856714345 group by v12;
create or replace view aggJoin1782483896580456021 as select v24 from movie_info as mi, aggView6862838015717835558 where mi.movie_id=aggView6862838015717835558.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view res as select MIN(v24) as v24 from aggJoin1782483896580456021;
select sum(v24) from res;