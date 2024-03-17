create or replace view aggView7474270028940347392 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6785087273305806350 as select movie_id as v12 from movie_keyword as mk, aggView7474270028940347392 where mk.keyword_id=aggView7474270028940347392.v1;
create or replace view aggView7099891268020767900 as select v12 from aggJoin6785087273305806350 group by v12;
create or replace view aggJoin4395053049989438284 as select movie_id as v12, info as v7 from movie_info as mi, aggView7099891268020767900 where mi.movie_id=aggView7099891268020767900.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView7260826241745531247 as select v12 from aggJoin4395053049989438284 group by v12;
create or replace view aggJoin3993377460973564925 as select title as v13 from title as t, aggView7260826241745531247 where t.id=aggView7260826241745531247.v12 and production_year>1990;
create or replace view res as select MIN(v13) as v24 from aggJoin3993377460973564925;
select sum(v24) from res;