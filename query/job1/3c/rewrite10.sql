create or replace view aggView7745422708476193050 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin5703085470090669400 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView7745422708476193050 where mk.movie_id=aggView7745422708476193050.v12;
create or replace view aggView7344556072838657331 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3840613205176715897 as select v12, v24 from aggJoin5703085470090669400 join aggView7344556072838657331 using(v1);
create or replace view aggView4172162806704545745 as select v12, MIN(v24) as v24 from aggJoin3840613205176715897 group by v12;
create or replace view aggJoin7880232510094413892 as select info as v7, v24 from movie_info as mi, aggView4172162806704545745 where mi.movie_id=aggView4172162806704545745.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view res as select MIN(v24) as v24 from aggJoin7880232510094413892;
select sum(v24) from res;