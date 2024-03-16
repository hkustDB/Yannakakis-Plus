create or replace view aggView4574186199961714523 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin137549388069166483 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView4574186199961714523 where mi_idx.info_type_id=aggView4574186199961714523.v1 and info>'5.0';
create or replace view aggView4301491873539359950 as select v14, MIN(v9) as v26 from aggJoin137549388069166483 group by v14;
create or replace view aggJoin8390247120544520309 as select movie_id as v14, keyword_id as v3, v26 from movie_keyword as mk, aggView4301491873539359950 where mk.movie_id=aggView4301491873539359950.v14;
create or replace view aggView6815965628493597148 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3870174628045618263 as select v14, v26 from aggJoin8390247120544520309 join aggView6815965628493597148 using(v3);
create or replace view aggView6003112468303651792 as select v14, MIN(v26) as v26 from aggJoin3870174628045618263 group by v14;
create or replace view aggJoin1991789300064147469 as select title as v15, v26 from title as t, aggView6003112468303651792 where t.id=aggView6003112468303651792.v14 and production_year>2005;
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin1991789300064147469;
