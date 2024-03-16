create or replace view aggView8933694383893943894 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin8271770564285133130 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView8933694383893943894 where mi_idx.info_type_id=aggView8933694383893943894.v1 and info>'2.0';
create or replace view aggView38578155543828528 as select v14, MIN(v9) as v26 from aggJoin8271770564285133130 group by v14;
create or replace view aggJoin8121472351969155124 as select id as v14, title as v15, v26 from title as t, aggView38578155543828528 where t.id=aggView38578155543828528.v14 and production_year>1990;
create or replace view aggView483654500202171809 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin8121472351969155124 group by v14;
create or replace view aggJoin9083089090961353858 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView483654500202171809 where mk.movie_id=aggView483654500202171809.v14;
create or replace view aggView3509266139166791711 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8613793955847510274 as select v26, v27 from aggJoin9083089090961353858 join aggView3509266139166791711 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin8613793955847510274;
