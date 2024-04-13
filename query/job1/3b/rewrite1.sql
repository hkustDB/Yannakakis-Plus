create or replace view aggView6301647538877771778 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8921693293114837571 as select movie_id as v12 from movie_keyword as mk, aggView6301647538877771778 where mk.keyword_id=aggView6301647538877771778.v1;
create or replace view aggView9137758067431521381 as select v12 from aggJoin8921693293114837571 group by v12;
create or replace view aggJoin984392618393251126 as select id as v12, title as v13, production_year as v16 from title as t, aggView9137758067431521381 where t.id=aggView9137758067431521381.v12 and production_year>2010;
create or replace view aggView8454919680941738918 as select v12, MIN(v13) as v24 from aggJoin984392618393251126 group by v12;
create or replace view aggJoin208269875933764389 as select v24 from movie_info as mi, aggView8454919680941738918 where mi.movie_id=aggView8454919680941738918.v12 and info= 'Bulgaria';
select MIN(v24) as v24 from aggJoin208269875933764389;
