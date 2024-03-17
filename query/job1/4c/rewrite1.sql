create or replace view aggView4786303958999495400 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin2429218210166074566 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView4786303958999495400 where mi_idx.info_type_id=aggView4786303958999495400.v1 and info>'2.0';
create or replace view aggView6342899092251165251 as select v14, MIN(v9) as v26 from aggJoin2429218210166074566 group by v14;
create or replace view aggJoin7788681684368667310 as select id as v14, title as v15, v26 from title as t, aggView6342899092251165251 where t.id=aggView6342899092251165251.v14 and production_year>1990;
create or replace view aggView6741637943593399466 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin7788681684368667310 group by v14;
create or replace view aggJoin213860739243608905 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView6741637943593399466 where mk.movie_id=aggView6741637943593399466.v14;
create or replace view aggView1371015496879619207 as select v3, MIN(v26) as v26, MIN(v27) as v27 from aggJoin213860739243608905 group by v3;
create or replace view aggJoin4800438976138180857 as select v26, v27 from keyword as k, aggView1371015496879619207 where k.id=aggView1371015496879619207.v3 and keyword LIKE '%sequel%';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin4800438976138180857;
