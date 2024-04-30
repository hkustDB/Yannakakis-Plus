create or replace view aggView8793840672434695990 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin2833741171410574725 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView8793840672434695990 where mi_idx.movie_id=aggView8793840672434695990.v14 and info>'9.0';
create or replace view aggView8224196587020295016 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1600026520971799406 as select movie_id as v14 from movie_keyword as mk, aggView8224196587020295016 where mk.keyword_id=aggView8224196587020295016.v3;
create or replace view aggView8958742588253933918 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin6939180229984194259 as select v14, v9, v27 from aggJoin2833741171410574725 join aggView8958742588253933918 using(v1);
create or replace view aggView444684617181626540 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin6939180229984194259 group by v14;
create or replace view aggJoin6878197043743964033 as select v27, v26 from aggJoin1600026520971799406 join aggView444684617181626540 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin6878197043743964033;
