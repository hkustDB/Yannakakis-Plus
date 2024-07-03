create or replace view aggView8165446884680461427 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin4755802971865845178 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView8165446884680461427 where mi_idx.info_type_id=aggView8165446884680461427.v1 and info>'9.0';
create or replace view aggView4070674587952813939 as select v14, MIN(v9) as v26 from aggJoin4755802971865845178 group by v14;
create or replace view aggJoin8672873805753371867 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView4070674587952813939 where t.id=aggView4070674587952813939.v14 and production_year>2010;
create or replace view aggView9071631920911493467 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8382434454013774603 as select movie_id as v14 from movie_keyword as mk, aggView9071631920911493467 where mk.keyword_id=aggView9071631920911493467.v3;
create or replace view aggView2548678721816266800 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin8672873805753371867 group by v14,v26;
create or replace view aggJoin7440473206944391493 as select v26, v27 from aggJoin8382434454013774603 join aggView2548678721816266800 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin7440473206944391493;
