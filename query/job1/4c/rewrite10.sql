create or replace view aggView925298234481796835 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin497327005886680555 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView925298234481796835 where mk.movie_id=aggView925298234481796835.v14;
create or replace view aggView3809876572511903523 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8888870071996563878 as select v14, v27 from aggJoin497327005886680555 join aggView3809876572511903523 using(v3);
create or replace view aggView5009416733903553439 as select v14, MIN(v27) as v27 from aggJoin8888870071996563878 group by v14;
create or replace view aggJoin3894937936549434249 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView5009416733903553439 where mi_idx.movie_id=aggView5009416733903553439.v14 and info>'2.0';
create or replace view aggView5040445026850878092 as select v1, MIN(v27) as v27, MIN(v9) as v26 from aggJoin3894937936549434249 group by v1;
create or replace view aggJoin2597880272515235551 as select v27, v26 from info_type as it, aggView5040445026850878092 where it.id=aggView5040445026850878092.v1 and info= 'rating';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin2597880272515235551;
