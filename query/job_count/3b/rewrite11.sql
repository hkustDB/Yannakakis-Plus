create or replace view aggView4171679003610779737 as select id as v12 from title as t where production_year>2010;
create or replace view aggJoin724231959917171645 as select movie_id as v12, info as v7 from movie_info as mi, aggView4171679003610779737 where mi.movie_id=aggView4171679003610779737.v12 and info= 'Bulgaria';
create or replace view aggView7346749220925387599 as select v12, COUNT(*) as annot from aggJoin724231959917171645 group by v12;
create or replace view aggJoin971835169761679450 as select keyword_id as v1, annot from movie_keyword as mk, aggView7346749220925387599 where mk.movie_id=aggView7346749220925387599.v12;
create or replace view aggView1797949514083335341 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6167220875933685214 as select annot from aggJoin971835169761679450 join aggView1797949514083335341 using(v1);
select SUM(annot) as v24 from aggJoin6167220875933685214;
