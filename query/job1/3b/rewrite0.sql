create or replace view aggView8309489104033288712 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin1886213197248534376 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView8309489104033288712 where mi.movie_id=aggView8309489104033288712.v12 and info= 'Bulgaria';
create or replace view aggView2233048119749302987 as select v12, MIN(v24) as v24 from aggJoin1886213197248534376 group by v12;
create or replace view aggJoin4654552921398358218 as select keyword_id as v1, v24 from movie_keyword as mk, aggView2233048119749302987 where mk.movie_id=aggView2233048119749302987.v12;
create or replace view aggView5149325499340293607 as select v1, MIN(v24) as v24 from aggJoin4654552921398358218 group by v1;
create or replace view aggJoin8453563427074425655 as select keyword as v2, v24 from keyword as k, aggView5149325499340293607 where k.id=aggView5149325499340293607.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin8453563427074425655;
select sum(v24) from res;