create or replace view aggJoin7766230328578512318 as (
with aggView9069664976722245174 as (select id as v14, title as v27 from title as t where production_year>2005)
select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView9069664976722245174 where mk.movie_id=aggView9069664976722245174.v14);
create or replace view aggJoin5473550209448674747 as (
with aggView5720163346312873808 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select v14, v27 from aggJoin7766230328578512318 join aggView5720163346312873808 using(v3));
create or replace view aggJoin2885799121833051859 as (
with aggView7402812033186370382 as (select id as v1 from info_type as it where info= 'rating')
select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView7402812033186370382 where mi_idx.info_type_id=aggView7402812033186370382.v1 and info>'5.0');
create or replace view aggJoin4155443015470122541 as (
with aggView967384493277639402 as (select v14, MIN(v9) as v26 from aggJoin2885799121833051859 group by v14)
select v27 as v27, v26 from aggJoin5473550209448674747 join aggView967384493277639402 using(v14));
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin4155443015470122541;
