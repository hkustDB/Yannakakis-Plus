create or replace view aggView5720501376528392316 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2444311310713197368 as select movie_id as v12 from movie_keyword as mk, aggView5720501376528392316 where mk.keyword_id=aggView5720501376528392316.v1;
create or replace view aggView449489610182979370 as select v12 from aggJoin2444311310713197368 group by v12;
create or replace view aggJoin6444455875274701732 as select movie_id as v12, info as v7 from movie_info as mi, aggView449489610182979370 where mi.movie_id=aggView449489610182979370.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView3659287078601731481 as select v12 from aggJoin6444455875274701732 group by v12;
create or replace view aggJoin6981774110289326256 as select title as v13 from title as t, aggView3659287078601731481 where t.id=aggView3659287078601731481.v12 and production_year>1990;
create or replace view res as select MIN(v13) as v24 from aggJoin6981774110289326256;
select sum(v24) from res;