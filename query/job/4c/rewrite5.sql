create or replace view aggJoin3046531495818697470 as (
with aggView5130516629754436832 as (select id as v14, title as v27 from title as t where production_year>1990)
select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView5130516629754436832 where mi_idx.movie_id=aggView5130516629754436832.v14 and info>'2.0');
create or replace view aggJoin3529488772217572953 as (
with aggView8192418133724579560 as (select id as v1 from info_type as it where info= 'rating')
select v14, v9, v27 from aggJoin3046531495818697470 join aggView8192418133724579560 using(v1));
create or replace view aggJoin2552097150635091993 as (
with aggView8873329285217632912 as (select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin3529488772217572953 group by v14,v27)
select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView8873329285217632912 where mk.movie_id=aggView8873329285217632912.v14);
create or replace view aggJoin9180829652214065294 as (
with aggView2343932022403656407 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select v27, v26 from aggJoin2552097150635091993 join aggView2343932022403656407 using(v3));
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin9180829652214065294;
