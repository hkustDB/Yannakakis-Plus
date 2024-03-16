create or replace view aggView89615810744677086 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin8382805450951838380 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView89615810744677086 where mi_idx.movie_id=aggView89615810744677086.v14 and info>'5.0';
create or replace view aggView9193220142068340203 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin6069021309435419841 as select v14, v9, v27 from aggJoin8382805450951838380 join aggView9193220142068340203 using(v1);
create or replace view aggView245210651856159305 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin6069021309435419841 group by v14;
create or replace view aggJoin9030309492710673816 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView245210651856159305 where mk.movie_id=aggView245210651856159305.v14;
create or replace view aggView752988682283223789 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6061689592192158258 as select v27, v26 from aggJoin9030309492710673816 join aggView752988682283223789 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin6061689592192158258;
