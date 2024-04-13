create or replace view aggView8301316462445568252 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5892422890011662111 as select movie_id as v12 from movie_keyword as mk, aggView8301316462445568252 where mk.keyword_id=aggView8301316462445568252.v1;
create or replace view aggView2741014141462333401 as select v12 from aggJoin5892422890011662111 group by v12;
create or replace view aggJoin8483241327857832532 as select movie_id as v12, info as v7 from movie_info as mi, aggView2741014141462333401 where mi.movie_id=aggView2741014141462333401.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView4831924540502857628 as select v12 from aggJoin8483241327857832532 group by v12;
create or replace view aggJoin2244441440031698319 as select title as v13, production_year as v16 from title as t, aggView4831924540502857628 where t.id=aggView4831924540502857628.v12 and production_year>2005;
create or replace view aggView7818755870791179399 as select v13 from aggJoin2244441440031698319 group by v13;
select min(v13) as v24 from aggView7818755870791179399;
