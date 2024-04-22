create or replace view aggJoin8457593055743064246 as (
with aggView3763816012075211230 as (select id as v14, title as v27 from title as t where production_year>2005)
select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView3763816012075211230 where mi_idx.movie_id=aggView3763816012075211230.v14 and info>'5.0');
create or replace view aggJoin8496949041898668477 as (
with aggView4223138996088118255 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v14 from movie_keyword as mk, aggView4223138996088118255 where mk.keyword_id=aggView4223138996088118255.v3);
create or replace view aggJoin5451344005841143553 as (
with aggView6075613743648367627 as (select id as v1 from info_type as it where info= 'rating')
select v14, v9, v27 from aggJoin8457593055743064246 join aggView6075613743648367627 using(v1));
create or replace view aggJoin8982928982311562220 as (
with aggView5454550418151982995 as (select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin5451344005841143553 group by v14,v27)
select v27, v26 from aggJoin8496949041898668477 join aggView5454550418151982995 using(v14));
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin8982928982311562220;
