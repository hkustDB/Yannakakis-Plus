create or replace view aggView7241876452783692775 as select id as v14, title as v15 from title as t where production_year>1990;
create or replace view aggJoin8066324313293297726 as (
with aggView5545313664640897054 as (select id as v1 from info_type as it where info= 'rating')
select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView5545313664640897054 where mi_idx.info_type_id=aggView5545313664640897054.v1 and info>'2.0');
create or replace view aggJoin8447749968907154400 as (
with aggView134187716829369003 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v14 from movie_keyword as mk, aggView134187716829369003 where mk.keyword_id=aggView134187716829369003.v3);
create or replace view aggJoin8873270126689506795 as (
with aggView2602794406532231846 as (select v14 from aggJoin8447749968907154400 group by v14)
select v14, v9 from aggJoin8066324313293297726 join aggView2602794406532231846 using(v14));
create or replace view aggView430394989001842727 as select v9, v14 from aggJoin8873270126689506795 group by v9,v14;
create or replace view aggJoin1365337033109074230 as (
with aggView5601270335740078982 as (select v14, MIN(v15) as v27 from aggView7241876452783692775 group by v14)
select v9, v27 from aggView430394989001842727 join aggView5601270335740078982 using(v14));
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin1365337033109074230;
