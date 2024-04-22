create or replace view aggView5726534201779493896 as select title as v15, id as v14 from title as t where production_year>2010;
create or replace view aggJoin5490374066689317768 as (
with aggView8655734941625320818 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v14 from movie_keyword as mk, aggView8655734941625320818 where mk.keyword_id=aggView8655734941625320818.v3);
create or replace view aggJoin4870743456864802319 as (
with aggView1616690055799089408 as (select id as v1 from info_type as it where info= 'rating')
select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView1616690055799089408 where mi_idx.info_type_id=aggView1616690055799089408.v1);
create or replace view aggJoin8792987812968323192 as (
with aggView3600446565029030386 as (select v14 from aggJoin5490374066689317768 group by v14)
select v14, v9 from aggJoin4870743456864802319 join aggView3600446565029030386 using(v14));
create or replace view aggJoin1543793364761320087 as (
with aggView5451536776611242360 as (select v9, v14 from aggJoin8792987812968323192 group by v9,v14)
select v14, v9 from aggView5451536776611242360 where v9>'9.0');
create or replace view aggJoin523564510942834131 as (
with aggView1364546062356026073 as (select v14, MIN(v9) as v26 from aggJoin1543793364761320087 group by v14)
select v15, v26 from aggView5726534201779493896 join aggView1364546062356026073 using(v14));
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin523564510942834131;
