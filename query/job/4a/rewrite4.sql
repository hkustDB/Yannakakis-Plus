create or replace view aggJoin2261502531449206775 as (
with aggView6507023705663091162 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v14 from movie_keyword as mk, aggView6507023705663091162 where mk.keyword_id=aggView6507023705663091162.v3);
create or replace view aggJoin3553771288326823337 as (
with aggView7825401258284134365 as (select id as v1 from info_type as it where info= 'rating')
select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView7825401258284134365 where mi_idx.info_type_id=aggView7825401258284134365.v1 and info>'5.0');
create or replace view aggJoin4767435043868753981 as (
with aggView4730738147724618564 as (select v14, MIN(v9) as v26 from aggJoin3553771288326823337 group by v14)
select id as v14, title as v15, production_year as v18, v26 from title as t, aggView4730738147724618564 where t.id=aggView4730738147724618564.v14 and production_year>2005);
create or replace view aggJoin3806678428388541470 as (
with aggView1585703230612959165 as (select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin4767435043868753981 group by v14,v26)
select v26, v27 from aggJoin2261502531449206775 join aggView1585703230612959165 using(v14));
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin3806678428388541470;
