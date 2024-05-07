create or replace view aggView6801014745056651596 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin371004002791988036 as select movie_id as v12 from movie_keyword as mk, aggView6801014745056651596 where mk.keyword_id=aggView6801014745056651596.v1;
create or replace view aggView6174185660200498602 as select v12 from aggJoin371004002791988036 group by v12;
create or replace view aggJoin8963267534752351626 as select movie_id as v12, info as v7 from movie_info as mi, aggView6174185660200498602 where mi.movie_id=aggView6174185660200498602.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView4878196316017937247 as select v12 from aggJoin8963267534752351626 group by v12;
create or replace view aggJoin7326225755818986602 as select title as v13, production_year as v16 from title as t, aggView4878196316017937247 where t.id=aggView4878196316017937247.v12 and production_year>2005;
create or replace view aggView1090229669955693414 as select v13 from aggJoin7326225755818986602;
select MIN(v13) as v24 from aggView1090229669955693414;
