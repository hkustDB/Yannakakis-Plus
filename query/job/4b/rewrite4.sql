create or replace view aggJoin7770563946360325346 as (
with aggView3655391208132741424 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v14 from movie_keyword as mk, aggView3655391208132741424 where mk.keyword_id=aggView3655391208132741424.v3);
create or replace view aggJoin7587502281009456994 as (
with aggView139279053629116367 as (select id as v1 from info_type as it where info= 'rating')
select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView139279053629116367 where mi_idx.info_type_id=aggView139279053629116367.v1 and info>'9.0');
create or replace view aggJoin1383183517434183844 as (
with aggView8073248889499014611 as (select v14, MIN(v9) as v26 from aggJoin7587502281009456994 group by v14)
select id as v14, title as v15, production_year as v18, v26 from title as t, aggView8073248889499014611 where t.id=aggView8073248889499014611.v14 and production_year>2010);
create or replace view aggJoin956801796996611256 as (
with aggView8081385503786181412 as (select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin1383183517434183844 group by v14,v26)
select v26, v27 from aggJoin7770563946360325346 join aggView8081385503786181412 using(v14));
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin956801796996611256;
