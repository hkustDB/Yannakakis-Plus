create or replace view aggView5615441402481858018 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin5536623538936970857 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView5615441402481858018 where mk.movie_id=aggView5615441402481858018.v14;
create or replace view aggView8879787060424372021 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin1591295563320828746 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView8879787060424372021 where mi_idx.info_type_id=aggView8879787060424372021.v1 and info>'2.0';
create or replace view aggView6486837961135871505 as select v14, MIN(v9) as v26 from aggJoin1591295563320828746 group by v14;
create or replace view aggJoin5970805420264678390 as select v3, v27 as v27, v26 from aggJoin5536623538936970857 join aggView6486837961135871505 using(v14);
create or replace view aggView8085747844660656202 as select v3, MIN(v27) as v27, MIN(v26) as v26 from aggJoin5970805420264678390 group by v3;
create or replace view aggJoin786232827811667961 as select v27, v26 from keyword as k, aggView8085747844660656202 where k.id=aggView8085747844660656202.v3 and keyword LIKE '%sequel%';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin786232827811667961;
