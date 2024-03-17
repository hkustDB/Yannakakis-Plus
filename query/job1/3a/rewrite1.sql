create or replace view aggView4209200570013577969 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8963583141184484685 as select movie_id as v12 from movie_keyword as mk, aggView4209200570013577969 where mk.keyword_id=aggView4209200570013577969.v1;
create or replace view aggView4797596945398019550 as select v12 from aggJoin8963583141184484685 group by v12;
create or replace view aggJoin374818709270130027 as select id as v12, title as v13 from title as t, aggView4797596945398019550 where t.id=aggView4797596945398019550.v12 and production_year>2005;
create or replace view aggView1081816403298125991 as select v12, MIN(v13) as v24 from aggJoin374818709270130027 group by v12;
create or replace view aggJoin9019181360735867963 as select v24 from movie_info as mi, aggView1081816403298125991 where mi.movie_id=aggView1081816403298125991.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
select MIN(v24) as v24 from aggJoin9019181360735867963;
