create or replace view aggView882985468664501857 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin6853805657391276262 as select id as v12, title as v13, production_year as v16 from title as t, aggView882985468664501857 where t.id=aggView882985468664501857.v12 and production_year>2010;
create or replace view aggView5854635303195184600 as select v12, MIN(v13) as v24 from aggJoin6853805657391276262 group by v12;
create or replace view aggJoin9209935572076524199 as select keyword_id as v1, v24 from movie_keyword as mk, aggView5854635303195184600 where mk.movie_id=aggView5854635303195184600.v12;
create or replace view aggView4612272756935379238 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8540380533848898861 as select v24 from aggJoin9209935572076524199 join aggView4612272756935379238 using(v1);
select MIN(v24) as v24 from aggJoin8540380533848898861;
