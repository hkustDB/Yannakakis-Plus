create or replace view aggView7796610168146322226 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin8192033149282946947 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView7796610168146322226 where ci.movie_id=aggView7796610168146322226.v23;
create or replace view aggView8575608287135584986 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin5177343388309604059 as select movie_id as v23, v35 from movie_keyword as mk, aggView8575608287135584986 where mk.keyword_id=aggView8575608287135584986.v8;
create or replace view aggView8909139365852439624 as select v23, MIN(v35) as v35 from aggJoin5177343388309604059 group by v23;
create or replace view aggJoin6455468252207187068 as select v14, v37 as v37, v35 from aggJoin8192033149282946947 join aggView8909139365852439624 using(v23);
create or replace view aggView5861157623837668665 as select v14, MIN(v37) as v37, MIN(v35) as v35 from aggJoin6455468252207187068 group by v14;
create or replace view aggJoin938056662806701422 as select name as v15, v37, v35 from name as n, aggView5861157623837668665 where n.id=aggView5861157623837668665.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin938056662806701422;
