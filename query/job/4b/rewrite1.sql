create or replace view aggView4256957831956574012 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin6070011834400448947 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView4256957831956574012 where mi_idx.info_type_id=aggView4256957831956574012.v1 and info>'9.0';
create or replace view aggView4331556058798123217 as select v14, MIN(v9) as v26 from aggJoin6070011834400448947 group by v14;
create or replace view aggJoin5039527372944827767 as select id as v14, title as v15, v26 from title as t, aggView4331556058798123217 where t.id=aggView4331556058798123217.v14 and production_year>2010;
create or replace view aggView6923227572734435768 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin5039527372944827767 group by v14;
create or replace view aggJoin7537321806214988103 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView6923227572734435768 where mk.movie_id=aggView6923227572734435768.v14;
create or replace view aggView1044132145671277189 as select v3, MIN(v26) as v26, MIN(v27) as v27 from aggJoin7537321806214988103 group by v3;
create or replace view aggJoin642303666322790330 as select v26, v27 from keyword as k, aggView1044132145671277189 where k.id=aggView1044132145671277189.v3 and keyword LIKE '%sequel%';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin642303666322790330;
