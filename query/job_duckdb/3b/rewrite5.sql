create or replace view aggView4446039343735790513 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin782682658122716709 as select movie_id as v12 from movie_keyword as mk, aggView4446039343735790513 where mk.keyword_id=aggView4446039343735790513.v1;
create or replace view aggView2484778479478824569 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin8773662831571628237 as select v12 from aggJoin782682658122716709 join aggView2484778479478824569 using(v12);
create or replace view aggView148250524936760990 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin6185801123731819670 as select v24 from aggJoin8773662831571628237 join aggView148250524936760990 using(v12);
select MIN(v24) as v24 from aggJoin6185801123731819670;
