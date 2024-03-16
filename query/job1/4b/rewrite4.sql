create or replace view aggView933528043809378242 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin7147852982146399172 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView933528043809378242 where mi_idx.info_type_id=aggView933528043809378242.v1 and info>'9.0';
create or replace view aggView5294683510265890432 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4306163422553793209 as select movie_id as v14 from movie_keyword as mk, aggView5294683510265890432 where mk.keyword_id=aggView5294683510265890432.v3;
create or replace view aggView1856749382127265645 as select v14 from aggJoin4306163422553793209 group by v14;
create or replace view aggJoin7893895662279922703 as select id as v14, title as v15 from title as t, aggView1856749382127265645 where t.id=aggView1856749382127265645.v14 and production_year>2010;
create or replace view aggView1476208924152743686 as select v14, MIN(v15) as v27 from aggJoin7893895662279922703 group by v14;
create or replace view aggJoin7264695795038966838 as select v9, v27 from aggJoin7147852982146399172 join aggView1476208924152743686 using(v14);
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin7264695795038966838;
