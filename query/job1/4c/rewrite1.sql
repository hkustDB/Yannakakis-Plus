create or replace view aggView7625394788404615339 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5018056195700091298 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView7625394788404615339 where mi_idx.info_type_id=aggView7625394788404615339.v1 and info>'2.0';
create or replace view aggView2507139857075203777 as select v14, MIN(v9) as v26 from aggJoin5018056195700091298 group by v14;
create or replace view aggJoin578346536462993063 as select id as v14, title as v15, v26 from title as t, aggView2507139857075203777 where t.id=aggView2507139857075203777.v14 and production_year>1990;
create or replace view aggView1320488501843093329 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin578346536462993063 group by v14;
create or replace view aggJoin1941338783247105488 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView1320488501843093329 where mk.movie_id=aggView1320488501843093329.v14;
create or replace view aggView4524999748586115114 as select v3, MIN(v26) as v26, MIN(v27) as v27 from aggJoin1941338783247105488 group by v3;
create or replace view aggJoin8995218135585420529 as select v26, v27 from keyword as k, aggView4524999748586115114 where k.id=aggView4524999748586115114.v3 and keyword LIKE '%sequel%';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin8995218135585420529;
