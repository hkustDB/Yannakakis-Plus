create or replace view aggView1771657185876010556 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin431555521009293053 as select movie_id as v12 from movie_keyword as mk, aggView1771657185876010556 where mk.keyword_id=aggView1771657185876010556.v1;
create or replace view aggView6255043583985922737 as select v12 from aggJoin431555521009293053 group by v12;
create or replace view aggJoin2392806876935856705 as select id as v12, title as v13, production_year as v16 from title as t, aggView6255043583985922737 where t.id=aggView6255043583985922737.v12 and production_year>1990;
create or replace view aggView6940739131954276787 as select v12, MIN(v13) as v24 from aggJoin2392806876935856705 group by v12;
create or replace view aggJoin5602822982761969853 as select v24 from movie_info as mi, aggView6940739131954276787 where mi.movie_id=aggView6940739131954276787.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
select MIN(v24) as v24 from aggJoin5602822982761969853;
