create or replace view aggView140694782985494295 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin6922538712312353283 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView140694782985494295 where mi_idx.movie_id=aggView140694782985494295.v14 and info>'2.0';
create or replace view aggView137996963489588461 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin4195437351031361610 as select v14, v9, v27 from aggJoin6922538712312353283 join aggView137996963489588461 using(v1);
create or replace view aggView5138812623103986368 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5606457292512413352 as select movie_id as v14 from movie_keyword as mk, aggView5138812623103986368 where mk.keyword_id=aggView5138812623103986368.v3;
create or replace view aggView6653511462023022587 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin4195437351031361610 group by v14,v27;
create or replace view aggJoin4980697815673506089 as select v27, v26 from aggJoin5606457292512413352 join aggView6653511462023022587 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin4980697815673506089;
