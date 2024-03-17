create or replace view aggView4834424582295946036 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin9195382712879078146 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView4834424582295946036 where mi.movie_id=aggView4834424582295946036.v12 and info= 'Bulgaria';
create or replace view aggView2222434902171225464 as select v12, MIN(v24) as v24 from aggJoin9195382712879078146 group by v12;
create or replace view aggJoin3651698880561997430 as select keyword_id as v1, v24 from movie_keyword as mk, aggView2222434902171225464 where mk.movie_id=aggView2222434902171225464.v12;
create or replace view aggView8507840784757873840 as select v1, MIN(v24) as v24 from aggJoin3651698880561997430 group by v1;
create or replace view aggJoin6187341592109914779 as select keyword as v2, v24 from keyword as k, aggView8507840784757873840 where k.id=aggView8507840784757873840.v1 and keyword LIKE '%sequel%';
select MIN(v24) as v24 from aggJoin6187341592109914779;
