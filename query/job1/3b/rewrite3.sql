create or replace view aggView3217560856163403979 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4512658031608064485 as select movie_id as v12 from movie_keyword as mk, aggView3217560856163403979 where mk.keyword_id=aggView3217560856163403979.v1;
create or replace view aggView757857191805695935 as select v12 from aggJoin4512658031608064485 group by v12;
create or replace view aggJoin3089435828708728209 as select id as v12, title as v13 from title as t, aggView757857191805695935 where t.id=aggView757857191805695935.v12 and production_year>2010;
create or replace view aggView3705909057126610770 as select v12, MIN(v13) as v24 from aggJoin3089435828708728209 group by v12;
create or replace view aggJoin6570031048843932968 as select v24 from movie_info as mi, aggView3705909057126610770 where mi.movie_id=aggView3705909057126610770.v12 and info= 'Bulgaria';
create or replace view res as select MIN(v24) as v24 from aggJoin6570031048843932968;
select sum(v24) from res;