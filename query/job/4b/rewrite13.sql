create or replace view aggView8386609314673148320 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin8204852835585203256 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView8386609314673148320 where mk.movie_id=aggView8386609314673148320.v14;
create or replace view aggView1232640560922857932 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin7659169477418779605 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView1232640560922857932 where mi_idx.info_type_id=aggView1232640560922857932.v1 and info>'9.0';
create or replace view aggView395258955143242722 as select v14, MIN(v9) as v26 from aggJoin7659169477418779605 group by v14;
create or replace view aggJoin8078683411544535687 as select v3, v27 as v27, v26 from aggJoin8204852835585203256 join aggView395258955143242722 using(v14);
create or replace view aggView8518725043411424657 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1723018029043340141 as select v27, v26 from aggJoin8078683411544535687 join aggView8518725043411424657 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin1723018029043340141;
