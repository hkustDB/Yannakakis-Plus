create or replace view aggView4400990485373639005 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin5479071930342904469 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView4400990485373639005 where mi_idx.movie_id=aggView4400990485373639005.v14 and info>'5.0';
create or replace view aggView9115849679771843634 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin133611785142710246 as select v14, v9, v27 from aggJoin5479071930342904469 join aggView9115849679771843634 using(v1);
create or replace view aggView5833255396821288101 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin133611785142710246 group by v14;
create or replace view aggJoin5331988032882267115 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView5833255396821288101 where mk.movie_id=aggView5833255396821288101.v14;
create or replace view aggView4806892492364179457 as select v3, MIN(v27) as v27, MIN(v26) as v26 from aggJoin5331988032882267115 group by v3;
create or replace view aggJoin7261457723894789965 as select v27, v26 from keyword as k, aggView4806892492364179457 where k.id=aggView4806892492364179457.v3 and keyword LIKE '%sequel%';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin7261457723894789965;
