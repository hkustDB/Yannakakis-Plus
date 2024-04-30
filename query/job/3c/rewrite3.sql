create or replace view aggView2984720351365204395 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin6320233917758547537 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView2984720351365204395 where mi.movie_id=aggView2984720351365204395.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView503425346602903668 as select v12, MIN(v24) as v24 from aggJoin6320233917758547537 group by v12;
create or replace view aggJoin8371052099157576723 as select keyword_id as v1, v24 from movie_keyword as mk, aggView503425346602903668 where mk.movie_id=aggView503425346602903668.v12;
create or replace view aggView3360509247803229363 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin137291930106460669 as select v24 from aggJoin8371052099157576723 join aggView3360509247803229363 using(v1);
select MIN(v24) as v24 from aggJoin137291930106460669;
