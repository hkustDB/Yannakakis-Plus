create or replace view aggView1852110061521630973 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5157892149857656582 as select movie_id as v14 from movie_keyword as mk, aggView1852110061521630973 where mk.keyword_id=aggView1852110061521630973.v3;
create or replace view aggView4866938414708149129 as select v14 from aggJoin5157892149857656582 group by v14;
create or replace view aggJoin4070657362016764063 as select id as v14, title as v15 from title as t, aggView4866938414708149129 where t.id=aggView4866938414708149129.v14 and production_year>2005;
create or replace view aggView4509594351204445963 as select v14, MIN(v15) as v27 from aggJoin4070657362016764063 group by v14;
create or replace view aggJoin1350976694788887210 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView4509594351204445963 where mi_idx.movie_id=aggView4509594351204445963.v14 and info>'5.0';
create or replace view aggView5660662969456075294 as select v1, MIN(v27) as v27, MIN(v9) as v26 from aggJoin1350976694788887210 group by v1;
create or replace view aggJoin9078336555214402089 as select v27, v26 from info_type as it, aggView5660662969456075294 where it.id=aggView5660662969456075294.v1 and info= 'rating';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin9078336555214402089;
