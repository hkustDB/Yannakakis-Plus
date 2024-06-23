create or replace view aggView8615563890257745119 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5822659239922493176 as select movie_id as v14 from movie_keyword as mk, aggView8615563890257745119 where mk.keyword_id=aggView8615563890257745119.v3;
create or replace view aggView5408739218150229078 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin4494851672759050529 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView5408739218150229078 where mi_idx.info_type_id=aggView5408739218150229078.v1 and info>'9.0';
create or replace view aggView5243299385809997572 as select v14 from aggJoin5822659239922493176 group by v14;
create or replace view aggJoin8152860048527466099 as select v14, v9 from aggJoin4494851672759050529 join aggView5243299385809997572 using(v14);
create or replace view aggView5804066297777816929 as select v14, MIN(v9) as v26 from aggJoin8152860048527466099 group by v14;
create or replace view aggJoin4725794320738395399 as select title as v15, v26 from title as t, aggView5804066297777816929 where t.id=aggView5804066297777816929.v14 and production_year>2010;
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin4725794320738395399;
