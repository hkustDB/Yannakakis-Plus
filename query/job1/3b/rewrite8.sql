create or replace view aggView5615720446251991651 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin9180684082351489021 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView5615720446251991651 where mi.movie_id=aggView5615720446251991651.v12 and info= 'Bulgaria';
create or replace view aggView2622949199187774779 as select v12, MIN(v24) as v24 from aggJoin9180684082351489021 group by v12;
create or replace view aggJoin7374995949170595314 as select keyword_id as v1, v24 from movie_keyword as mk, aggView2622949199187774779 where mk.movie_id=aggView2622949199187774779.v12;
create or replace view aggView6169041850883180144 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1383770655899531485 as select v24 from aggJoin7374995949170595314 join aggView6169041850883180144 using(v1);
select MIN(v24) as v24 from aggJoin1383770655899531485;
