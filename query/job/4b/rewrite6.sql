create or replace view aggJoin6349724900216285645 as (
with aggView2830964823791170010 as (select id as v14, title as v27 from title as t where production_year>2010)
select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView2830964823791170010 where mk.movie_id=aggView2830964823791170010.v14);
create or replace view aggJoin2027525481582060909 as (
with aggView1039652410906805864 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select v14, v27 from aggJoin6349724900216285645 join aggView1039652410906805864 using(v3));
create or replace view aggJoin3529822667588934546 as (
with aggView3802227077411338596 as (select id as v1 from info_type as it where info= 'rating')
select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView3802227077411338596 where mi_idx.info_type_id=aggView3802227077411338596.v1 and info>'9.0');
create or replace view aggJoin3938402365719897382 as (
with aggView5477160239104605815 as (select v14, MIN(v9) as v26 from aggJoin3529822667588934546 group by v14)
select v27 as v27, v26 from aggJoin2027525481582060909 join aggView5477160239104605815 using(v14));
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin3938402365719897382;
