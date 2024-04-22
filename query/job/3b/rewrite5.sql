create or replace view aggJoin7157016195872220780 as (
with aggView6776720546739625156 as (select id as v12, title as v24 from title as t where production_year>2010)
select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView6776720546739625156 where mk.movie_id=aggView6776720546739625156.v12);
create or replace view aggJoin515967052767582092 as (
with aggView8501409556892180749 as (select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id)
select v1, v24 as v24 from aggJoin7157016195872220780 join aggView8501409556892180749 using(v12));
create or replace view aggJoin3379380952387246646 as (
with aggView2251754074473993279 as (select id as v1 from keyword as k where keyword LIKE '%sequel%')
select v24 from aggJoin515967052767582092 join aggView2251754074473993279 using(v1));
select MIN(v24) as v24 from aggJoin3379380952387246646;
